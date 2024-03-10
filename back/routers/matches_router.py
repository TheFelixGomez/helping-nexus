from bson import ObjectId
from fastapi import APIRouter, HTTPException

from database import users_collection, wishes_collection

router = APIRouter(
    prefix="/matches",
    tags=["Matches"],
)


# get all the wishes matched for a user
@router.get("/")
async def get_matches(user_id: str):
    # find if the user exists
    user = await users_collection.find_one({"_id": ObjectId(user_id)})
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    # find all wishes the user has been matched for and the last message if any for each wish
    wishes = await wishes_collection.aggregate([
        {
            "$match": {
                "volunteers": {"$in": [user_id]}
            }
        },
        {"$addFields": {"wid": {"$toString": "$_id"}}},
        {
            "$lookup": {
                "from": "messages",
                "let": {"wid": "$wid"},
                "pipeline": [
                    {
                        "$match": {
                            # check if the message is for the wish and the user is in either the from or to fields
                            "$expr": {
                                "$and": [
                                    {
                                        "$eq": ["$wish_id", "$$wid"]
                                    },
                                    {
                                        "$or": [
                                            {
                                                "$eq": ["$from_user_id", user_id]
                                            },
                                            {
                                                "$eq": ["$to_user_id", user_id]
                                            }
                                        ]
                                    }
                                ]
                            }
                        }
                    },
                    {
                        "$sort": {
                            "created_at": -1
                        }
                    },
                    {
                        "$limit": 1
                    },
                    {
                        "$project": {
                            "_id": {
                                "$toString": "$_id"
                            },
                            "from_user_id": 1,
                            "to_user_id": 1,
                            "message": 1,
                            "created_at": 1
                        }
                    }
                ],
                "as": "last_message"
            }
        },
        {
            "$unwind": {
                "path": "$last_message",
                "preserveNullAndEmptyArrays": True
            }
        },
        {
            "$project": {
                "_id": {
                    "$toString": "$_id"
                },
                "title": 1,
                "created_at": 1,
                "last_message": {
                    "$ifNull": ["$last_message", {}]
                }
            }
        }
    ]).to_list(100)

    if not wishes:
        return []

    return wishes


# get all the volunteers matched for a wish
@router.get("/volunteers")
async def get_volunteers(wish_id: str):
    # find if the wish exists
    wish = await wishes_collection.find_one({"_id": ObjectId(wish_id)})
    if wish is None:
        raise HTTPException(status_code=404, detail="Wish not found")

    # find all the volunteers matched for the wish and the last message if any for each volunteer
    volunteers = await users_collection.aggregate([
        {
            "$match": {
                "wishes": {"$in": [wish_id]}
            }
        },
        {"$addFields": {"uid": {"$toString": "$_id"}}},
        {
            "$lookup": {
                "from": "messages",
                "let": {"uid": "$uid"},
                "pipeline": [
                    {
                        "$match": {
                            # check if the message is for the wish and the user is in either the from or to fields
                            "$expr": {
                                "$and": [
                                    {
                                        "$eq": ["$wish_id", wish_id]
                                    },
                                    {
                                        "$or": [
                                            {
                                                "$eq": ["$from_user_id", "$$uid"]
                                            },
                                            {
                                                "$eq": ["$to_user_id", "$$uid"]
                                            }
                                        ]
                                    }
                                ]
                            }
                        }
                    },
                    {
                        "$sort": {
                            "created_at": -1
                        }
                    },
                    {
                        "$limit": 1
                    },
                    {
                        "$project": {
                            "_id": {
                                "$toString": "$_id"
                            },
                            "from_user_id": 1,
                            "to_user_id": 1,
                            "message": 1,
                            "created_at": 1,
                            "wish_id": 1
                        }
                    }
                ],
                "as": "last_message"
            }
        },
        {
            "$unwind": {
                "path": "$last_message",
                "preserveNullAndEmptyArrays": True
            }
        },
        {
            "$project": {
                "_id": {
                    "$toString": "$_id"
                },
                "first_name": 1,
                "last_name": 1,
                "email": 1,
                "last_message": {
                    "$ifNull": ["$last_message", {}]
                }
            }
        }
    ]).to_list(100)

    return volunteers
