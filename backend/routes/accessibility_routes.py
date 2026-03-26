from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database import SessionLocal
from app import models, schemas
from services.analytics_service import get_zone_clusters

router = APIRouter()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# -----------------------------
# Submit accessibility test
# -----------------------------
@router.post("/submit-test")
def submit_test(log: schemas.AccessibilityLogCreate,
                db: Session = Depends(get_db)):

    db_log = models.AccessibilityLog(**log.dict())

    db.add(db_log)
    db.commit()
    db.refresh(db_log)

    return {"status": "stored"}


# -----------------------------
# Get clustered zones
# -----------------------------
@router.get("/zones")
def zones(db: Session = Depends(get_db)):

    return get_zone_clusters(db)


# -----------------------------
# Indoor heatmap
# -----------------------------
@router.get("/indoor-map/{building}/{floor}")
def indoor_map(building: str,
               floor: str,
               db: Session = Depends(get_db)):

    logs = db.query(models.AccessibilityLog).filter(
        models.AccessibilityLog.building == building,
        models.AccessibilityLog.floor == floor
    ).all()

    result = {}

    for log in logs:

        score = log.download_speed - log.ping_ms

        if score > 50:
            level = "High"
        elif score > 20:
            level = "Medium"
        else:
            level = "Low"

        result[log.zone] = level

    return result


# -----------------------------
# Outdoor map markers
# -----------------------------
@router.get("/outdoor-map")
def outdoor_map(db: Session = Depends(get_db)):

    logs = db.query(models.AccessibilityLog).all()

    results = []

    for log in logs:

        if log.latitude and log.longitude:

            score = log.download_speed - log.ping_ms

            if score > 50:
                level = "High"
            elif score > 20:
                level = "Medium"
            else:
                level = "Low"

            results.append({
                "lat": log.latitude,
                "lon": log.longitude,
                "level": level
            })

    return results


# -----------------------------
# Basic stats
# -----------------------------
@router.get("/stats")
def stats(db: Session = Depends(get_db)):

    total = db.query(models.AccessibilityLog).count()

    return {"total_measurements": total}