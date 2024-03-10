from typing import Optional

from pydantic import BaseModel, Field

from schemas.common import Location, PyObjectId


class Wishes(BaseModel):
    wish_id: str


class UserBase(BaseModel):
    id: Optional[PyObjectId] = Field(alias="_id", default=None)
    first_name: str
    last_name: str
    email: str
    phone: str | None = None
    dob: str
    location: Location
    wisher: bool = False
    company_name: str | None = None


class UserIn(UserBase):
    auth_id: str


class UserOut(UserBase):
    profile_picture: str | None = None


class UserInDB(UserBase):
    wishes: list[Wishes] = []
    proposed_wishes: list[Wishes] = []
    rejected_wishes: list[Wishes] = []


