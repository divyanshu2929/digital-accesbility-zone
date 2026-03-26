from pydantic import BaseModel
from typing import Optional

class AccessibilityLogCreate(BaseModel):

    mode: str

    building: Optional[str]
    floor: Optional[str]
    zone: Optional[str]

    latitude: Optional[float]
    longitude: Optional[float]

    ping_ms: float
    download_speed: float
    api_response_ms: float

    ram_available: float