from fastapi import APIRouter

from schemas import users_schema

router = APIRouter(
    prefix="/users",
    tags=["Users"],
)


@router.post("/", response_model=users_schema.UserOut)
async def create_user(user: users_schema.UserIn):

    # Create the user on the DB with the UserCreateDB Model
    user_to_create = users_schema.UserInDB(**user.dict())

    # Create the user

    return users_schema.UserOut(**user.dict())

