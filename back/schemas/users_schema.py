from typing import Annotated

from fastapi import UploadFile, File
from pydantic import BaseModel

from schemas.common import Location


class Wishes(BaseModel):
    wish_id: str


class UserBase(BaseModel):
    first_name: str
    last_name: str
    email: str
    phone: str | None = None
    dob: str
    profile_picture: str | None = None
    location: Location
    wisher: bool = False
    company_name: str | None = None


class UserIn(UserBase):
    password: str
    profile_picture: Annotated[bytes, File] = UploadFile


class UserOut(UserBase):
    pass


class UserInDB(UserBase):
    password: str
    wishes: list[Wishes] = []
    proposed_wishes: list[Wishes] = []
    rejected_wishes: list[Wishes] = []


