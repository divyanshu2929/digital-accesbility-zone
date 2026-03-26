from sqlalchemy.orm import Session
from app.models import AccessibilityLog
from ml.clustering import run_clustering

def get_zone_clusters(db: Session):

    logs = db.query(AccessibilityLog).all()

    data = []

    for log in logs:

        data.append({
            "zone": log.zone,
            "ping_ms": log.ping_ms,
            "download_speed": log.download_speed,
            "api_response_ms": log.api_response_ms,
            "ram_available": log.ram_available
        })

    return run_clustering(data)