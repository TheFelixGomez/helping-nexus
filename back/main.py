from fastapi import FastAPI

from routers import users_router, messages_router, wishes_router, matches_router

app = FastAPI(
    title="Helping Nexus API",
    description="API for the Helping Nexus App",
    version="0.0.1"
)

app.include_router(users_router.router)
app.include_router(messages_router.router)
app.include_router(wishes_router.router)
app.include_router(matches_router.router)


@app.get("/")
async def root():
    return {"message": "Hello World"}
