from bson import ObjectId
from fastapi import APIRouter, HTTPException

from database import users_collection, messages_collection
from schemas import messages_schema

router = APIRouter(
    prefix="/messages",
    tags=["Messages"],
)


@router.post("/", response_model=messages_schema.MessageOut)
async def send_message(message: messages_schema.MessageIn):
    sender = await users_collection.find_one({"_id": ObjectId(message.from_user_id)})
    receiver = await users_collection.find_one({"_id": ObjectId(message.to_user_id)})

    if sender is None or receiver is None:
        raise HTTPException(status_code=404, detail="User not found")

    message_data = messages_schema.MessageInDB(**message.dict())

    new_msg = await messages_collection.insert_one(message_data.dict())
    msg_created = await messages_collection.find_one(
        {"_id": new_msg.inserted_id}
    )

    return messages_schema.MessageOut(**msg_created)


@router.get("/{user_id}", response_model=list[messages_schema.MessageOut])
async def get_messages(user_id: str):
    # find all messages from the user or to the user sorted by date
    messages = await messages_collection.find(
        {
            "$or": [
                {"from_user_id": user_id},
                {"to_user_id": user_id}
            ]
        }
    ).sort("created_at", -1).to_list(100)

    if not messages:
        return []

    return [messages_schema.MessageOut(**msg) for msg in messages]