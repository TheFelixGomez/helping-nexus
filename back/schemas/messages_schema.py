from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field

from schemas.common import get_time_now, PyObjectId


class MessageBase(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id", default=None)
    created_at: datetime = Field(default_factory=get_time_now)
    from_user_id: str
    to_user_id: str
    message: str


class MessageIn(MessageBase):
    pass


class MessageOut(MessageBase):
    pass
