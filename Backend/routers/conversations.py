from fastapi import APIRouter, Depends, status
from sqlalchemy.orm import Session

from db.database import get_db
from schemas.conversation import ConversationOut, ConversationWithMessages
from schemas.message import MessageCreate, SendMessageResponse
from services import conversation_service

router = APIRouter(prefix="/api/conversations", tags=["conversations"])


@router.post("", response_model=ConversationOut, status_code=status.HTTP_201_CREATED)
def create_conversation(db: Session = Depends(get_db)):
    """Start a new, empty conversation."""
    return conversation_service.create_conversation(db)


@router.post("/{conversation_id}/messages", response_model=SendMessageResponse)
def send_message(conversation_id: int, body: MessageCreate, db: Session = Depends(get_db)):
    """Send a user message and get the chat's reply (full history is used as context)."""
    user_message, assistant_message = conversation_service.send_message(
        db, conversation_id, body.content
    )
    return SendMessageResponse(user_message=user_message, assistant_message=assistant_message)


@router.get("/{conversation_id}", response_model=ConversationWithMessages)
def get_conversation(conversation_id: int, db: Session = Depends(get_db)):
    """Fetch a conversation with all of its messages."""
    return conversation_service.get_conversation(db, conversation_id)
