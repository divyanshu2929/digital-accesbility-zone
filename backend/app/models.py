from sqlalchemy import Column, Integer, Float, String, DateTime
from datetime import datetime
from .database import Base

class AccessibilityLog(Base):
    __tablename__ = "accessibility_logs"

    id = Column(Integer, primary_key=True, index=True)

    mode = Column(String)

    building = Column(String, nullable=True)
    floor = Column(String, nullable=True)
    zone = Column(String, nullable=True)

    latitude = Column(Float, nullable=True)
    longitude = Column(Float, nullable=True)

    ping_ms = Column(Float)
    download_speed = Column(Float)
    api_response_ms = Column(Float)

    ram_available = Column(Float)

    timestamp = Column(DateTime, default=datetime.utcnow)