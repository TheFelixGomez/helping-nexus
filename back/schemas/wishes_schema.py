from datetime import datetime
from typing import Optional

from fastapi import UploadFile
from pydantic import BaseModel, Field

from schemas.common import Location, get_time_now, PyObjectId


class Volunteers(BaseModel):
    user_id: str


class WishBase(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id", default=None)
    created_at: datetime = Field(default_factory=get_time_now)
    user_id: str
    title: str
    location: Location
    volunteers: list[Volunteers] = []
    proposed_volunteers: list[Volunteers] = []
    rejected_volunteers: list[Volunteers] = []


class WishIn(WishBase):
    password: str
    profile_picture = UploadFile


class WishOut(WishBase):
    pass
