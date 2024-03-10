from dataclasses import Field
from datetime import datetime

from pydantic import BaseModel

from schemas.common import get_time_now


class MessageBase(BaseModel):
    _id: str
    created_at: datetime = Field(default_factory=get_time_now)
    from_user_id: str
    to_user_id: str
    message: str


class MessageIn(MessageBase):
    pass


class MessageOut(MessageBase):
    pass
