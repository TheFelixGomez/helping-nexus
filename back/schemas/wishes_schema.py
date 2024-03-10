from datetime import datetime
from typing import Optional

from fastapi import UploadFile
from pydantic import BaseModel, Field

from schemas.common import Location, get_time_now, PyObjectId


class Volunteers(BaseModel):
    user_id: str


class WishBase(BaseModel):
    user_id: str
    title: str
    location: Location


class WishIn(WishBase):
    pass


class WishOut(WishBase):
    id: Optional[PyObjectId] = Field(alias="_id", default=None)
    created_at: datetime


class WishInDB(WishBase):
    created_at: datetime = Field(default_factory=get_time_now)
    volunteers: list[Volunteers] = []
    proposed_volunteers: list[Volunteers] = []
    rejected_volunteers: list[Volunteers] = []
