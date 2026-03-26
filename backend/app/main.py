from fastapi import FastAPI
from app.database import Base, engine
from routes.accessibility_routes import router

app = FastAPI(
    title="Digital Accessibility Zone Mapping API"
)

Base.metadata.create_all(bind=engine)

app.include_router(router)