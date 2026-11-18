from datetime import datetime

from pydantic import BaseModel, ConfigDict

from schemas.message import MessageOut


class ConversationOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    created_at: datetime


class ConversationWithMessages(ConversationOut):
    messages: list[MessageOut]
