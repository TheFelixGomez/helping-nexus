from pydantic import BaseModel
from datetime import datetime, timezone


class Location(BaseModel):
    address: str
    address_2: str | None = None
    city: str
    state: str
    zip: str
    country: str = 'US'


def get_time_now():
    return datetime.now(timezone.utc)
