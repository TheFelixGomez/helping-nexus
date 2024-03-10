import certifi
from decouple import config
from motor.motor_asyncio import AsyncIOMotorClient, AsyncIOMotorDatabase, AsyncIOMotorCollection

client = AsyncIOMotorClient(config("MONGO_DB").strip('\"'), tlsCAFile=certifi.where())

mongo_db: AsyncIOMotorDatabase = client.helping_nexus

users_collection: AsyncIOMotorCollection = mongo_db.users
messages_collection: AsyncIOMotorCollection = mongo_db.messages
wishes_collection: AsyncIOMotorCollection = mongo_db.wishes
