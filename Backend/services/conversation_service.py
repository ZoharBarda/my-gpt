"""Conversation/message persistence and the send-message flow."""
from sqlalchemy import select
from sqlalchemy.orm import Session

from db.models import Conversation, Message
from services import chat_service
from services.errors import AppError


def create_conversation(db: Session) -> Conversation:
    conversation = Conversation()
    db.add(conversation)
    db.commit()
    db.refresh(conversation)
    return conversation


def get_conversation(db: Session, conversation_id: int) -> Conversation:
    conversation = db.get(Conversation, conversation_id)
    if conversation is None:
        raise AppError(404, "Conversation not found. Please start a new conversation.")
    return conversation


def _save_message(db: Session, conversation_id: int, role: str, content: str) -> Message:
    message = Message(conversation_id=conversation_id, role=role, content=content)
    db.add(message)
    db.commit()
    db.refresh(message)
    return message


def send_message(db: Session, conversation_id: int, content: str) -> tuple[Message, Message]:
    """Store the user message, ask OpenAI with the full history, store the reply."""
    get_conversation(db, conversation_id)
    user_message = _save_message(db, conversation_id, "user", content)

    rows = db.scalars(
        select(Message).where(Message.conversation_id == conversation_id).order_by(Message.id)
    ).all()
    history = [{"role": m.role, "content": m.content} for m in rows]

    try:
        reply = chat_service.generate_reply(history)
    except AppError:
        # Remove the unanswered message so a retry doesn't leave duplicates in the history
        db.delete(user_message)
        db.commit()
        raise

    assistant_message = _save_message(db, conversation_id, "assistant", reply)
    return user_message, assistant_message
