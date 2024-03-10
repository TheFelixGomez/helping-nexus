from bson import ObjectId
from fastapi import APIRouter, HTTPException, Body

from database import users_collection, wishes_collection
from schemas import wishes_schema

router = APIRouter(
    prefix="/wishes",
    tags=["Wishes"],
)


# create a new wish
@router.post("/", response_model=wishes_schema.WishOut)
async def create_wish(wish: wishes_schema.WishIn):
    # find user
    user = await users_collection.find_one({"_id": ObjectId(wish.user_id)})

    if user is None:
        raise HTTPException(status_code=422, detail="User not found")

    if user.get('wisher') is False:
        raise HTTPException(status_code=403, detail="User is not a wisher")

    wish_in = wishes_schema.WishInDB(**wish.dict())

    new_wish = await wishes_collection.insert_one(wish_in.dict())
    wish_created = await wishes_collection.find_one(
        {"_id": new_wish.inserted_id}
    )

    return wishes_schema.WishOut(**wish_created)


# get all wishes
@router.get("/new", response_model=list[wishes_schema.WishOut])
async def get_new_wishes(user_id: str):
    # find if the user exists
    user = await users_collection.find_one({"_id": ObjectId(user_id)})
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    # find all wishes minus the wishes from the user minus the wishes in either users. wishes, proposed_wishes,
    #  or rejected_wishes and sort them by oldest to newest
    wishes = await wishes_collection.find(
        {
            "$and": [
                {"user_id": {"$ne": user_id}},
                {"_id": {"$nin": user.get('rejected_wishes', [])}},  # wishes the user has rejected
                {"volunteers": {"$nin": [user_id]}},  # wishes the user has volunteered for
                {"proposed_volunteers": {"$nin": [user_id]}},  # wishes the user has proposed to volunteer for
                {"rejected_volunteers": {"$nin": [user_id]}},  # wishes the user has been rejected volunteering for
            ]
        },
    ).sort("created_at", 1).to_list(100)

    if not wishes:
        return []

    return [wishes_schema.WishOut(**wish) for wish in wishes]


# propose to volunteer for a wish
@router.post("/propose")
async def propose_to_volunteer(wish_id: str = Body(...), user_id: str = Body(...)):
    # find if the user exists
    user = await users_collection.find_one({"_id": ObjectId(user_id)})
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    # find the wish
    wish = await wishes_collection.find_one({"_id": ObjectId(wish_id)})
    if wish is None:
        raise HTTPException(status_code=404, detail="Wish not found")

    match = False

    # if the wish is in the user.proposed_wishes list, remove the wish from the list and put it on the user.wishes list
    # and also add the user_id to the wish.volunteers list
    if wish_id in user.get('proposed_wishes', []):
        await users_collection.update_one(
            {"_id": ObjectId(user_id)},
            {"$pull": {"proposed_wishes": wish_id}, "$addToSet": {"wishes": wish_id}}
        )
        await wishes_collection.update_one(
            {"_id": ObjectId(wish_id)},
            {"$addToSet": {"volunteers": user_id}}
        )

        match = True
    else:
        # add the user to the proposed_volunteers list
        await wishes_collection.update_one(
            {"_id": ObjectId(wish_id)},
            {"$addToSet": {"proposed_volunteers": user_id}}
        )

    return {"match": match}


# propose a volunteer to a wish
@router.post("/propose-volunteer")
async def propose_volunteer(wish_id: str = Body(...), user_id: str = Body(...)):
    # find if the user exists
    user = await users_collection.find_one({"_id": ObjectId(user_id)})
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    # find the wish
    wish = await wishes_collection.find_one({"_id": ObjectId(wish_id)})
    if wish is None:
        raise HTTPException(status_code=404, detail="Wish not found")

    match = False

    # if the user_id is in the wish.proposed_volunteers list, remove the user_id from the list and put it on the
    # wish.volunteers list and also add the wish_id to the user.wishes list
    if user_id in wish.get('proposed_volunteers', []):
        await wishes_collection.update_one(
            {"_id": ObjectId(wish_id)},
            {"$pull": {"proposed_volunteers": user_id}, "$addToSet": {"volunteers": user_id}}
        )
        await users_collection.update_one(
            {"_id": ObjectId(user_id)},
            {"$addToSet": {"wishes": wish_id}}
        )

        match = True
    else:
        # add the wish to the proposed_wishes list
        await users_collection.update_one(
            {"_id": ObjectId(user_id)},
            {"$addToSet": {"proposed_wishes": wish_id}}
        )

    return {"match": match}


# reject a wish from a volunteer's pov
@router.post("/reject")
async def reject_wish(wish_id: str = Body(...), user_id: str = Body(...)):
    # find if the user exists
    user = await users_collection.find_one({"_id": ObjectId(user_id)})
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    # find the wish
    wish = await wishes_collection.find_one({"_id": ObjectId(wish_id)})
    if wish is None:
        raise HTTPException(status_code=404, detail="Wish not found")

    # if the wish is in the user.wishes list, remove the wish from the list
    if user_id in wish.get('volunteers', []):
        await users_collection.update_one(
            {"_id": ObjectId(user_id)},
            {"$pull": {"wishes": wish_id}}
        )
        await wishes_collection.update_one(
            {"_id": ObjectId(wish_id)},
            {"$pull": {"volunteers": user_id}}
        )
    elif user_id in wish.get('proposed_volunteers', []):
        await wishes_collection.update_one(
            {"_id": ObjectId(wish_id)},
            {"$pull": {"proposed_volunteers": user_id}}
        )

    # add the user to the rejected_wishes list
    await users_collection.update_one(
        {"_id": ObjectId(user_id)},
        {"$addToSet": {"rejected_wishes": wish_id}}
    )

    return {"message": "Wish rejected"}


# reject a volunteer
@router.post("/reject-volunteer")
async def reject_volunteer(wish_id: str = Body(...), user_id: str = Body(...)):
    # find if the user exists
    user = await users_collection.find_one({"_id": ObjectId(user_id)})
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")

    # find the wish
    wish = await wishes_collection.find_one({"_id": ObjectId(wish_id)})
    if wish is None:
        raise HTTPException(status_code=404, detail="Wish not found")

    # if the wish is in the user.proposed_wishes list, remove the wish from the list
    if wish_id in user.get('wishes', []):
        await users_collection.update_one(
            {"_id": ObjectId(user_id)},
            {"$pull": {"wishes": wish_id}}
        )
        await wishes_collection.update_one(
            {"_id": ObjectId(wish_id)},
            {"$pull": {"volunteers": user_id}}
        )
    elif wish_id in user.get('proposed_wishes', []):
        await users_collection.update_one(
            {"_id": ObjectId(user_id)},
            {"$pull": {"proposed_wishes": wish_id}}
        )

    # add the user to the rejected_volunteers list
    await wishes_collection.update_one(
        {"_id": ObjectId(wish_id)},
        {"$addToSet": {"rejected_volunteers": user_id}}
    )

    return {"message": "Volunteer rejected"}
