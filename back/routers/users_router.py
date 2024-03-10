from typing import Annotated

from bson import ObjectId

import storage

from fastapi import APIRouter, UploadFile, Form, HTTPException

from database import users_collection
from schemas import users_schema

router = APIRouter(
    prefix="/users",
    tags=["Users"],
)


@router.post("/", response_model=users_schema.UserOut)
async def create_user(user: users_schema.UserIn):
    # find if the user exists
    stored_user = await users_collection.find_one({"email": user.email})

    if stored_user:
        raise HTTPException(status_code=400, detail="User already exists")

    # Create the user on the DB with the UserCreateDB Model
    user_to_create = users_schema.UserInDB(**user.dict())

    # Create the user
    new_user = await users_collection.insert_one(user_to_create.dict())
    user_created = await users_collection.find_one(
        {"_id": new_user.inserted_id}
    )

    return users_schema.UserOut(**user_created)


@router.post("/profile-picture")
async def upload_profile_picture(user_id: Annotated[str, Form()], profile_picture: UploadFile):
    # find if the user exists
    user = await users_collection.find_one({"_id": ObjectId(user_id)})

    if not user:
        raise HTTPException(status_code=422, detail="User not found")

    # upload the profile picture to the server
    file_url, filename = storage.upload_profile_picture(profile_picture)

    # Save the profile picture to the DB for the user
    result = await users_collection.update_one({"_id": ObjectId(user_id)}, {"$set": {"profile_picture": filename}})

    if not result.modified_count:
        raise HTTPException(status_code=500, detail="Could not save profile picture")

    return {
        "message": "Profile picture uploaded successfully",
        "profile_picture": file_url,
    }


# get profile picture
@router.get("/profile-picture")
async def get_profile_picture(user_id: str):
    # find if the user exists
    user = await users_collection.find_one({"_id": ObjectId(user_id)})

    if not user:
        raise HTTPException(status_code=422, detail="User not found")

    if "profile_picture" in user:
        return {
            "profile_picture": storage.get_file_url(user["profile_picture"])
        }
    else:
        return {
            "profile_picture": None
        }
