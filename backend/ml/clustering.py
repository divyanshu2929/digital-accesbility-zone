import numpy as np
from sklearn.cluster import KMeans


def compute_score(d):
    """
    Convert raw metrics into normalized accessibility score (0–1)
    """

    ping_score = max(0, 1 - d["ping_ms"] / 200)
    download_score = min(d["download_speed"] / 50, 1)
    api_score = max(0, 1 - d["api_response_ms"] / 300)
    ram_score = min(d["ram_available"] / 8000, 1)

    score = (
        0.4 * download_score +
        0.3 * ping_score +
        0.2 * api_score +
        0.1 * ram_score
    )

    return score


def run_clustering(data):

    if len(data) < 3:
        return []

    # ----------------------------------
    # Compute accessibility scores
    # ----------------------------------
    scores = np.array([[compute_score(d)] for d in data])

    # ----------------------------------
    # Run KMeans clustering
    # ----------------------------------
    kmeans = KMeans(n_clusters=3, random_state=42)

    labels = kmeans.fit_predict(scores)

    # ----------------------------------
    # Sort clusters by accessibility
    # ----------------------------------
    centers = kmeans.cluster_centers_.flatten()

    order = np.argsort(centers)

    label_map = {
        order[0]: "Low",
        order[1]: "Medium",
        order[2]: "High"
    }

    # ----------------------------------
    # Build results
    # ----------------------------------
    results = []

    for i, d in enumerate(data):

        results.append({
            "zone": d.get("zone"),
            "latitude": d.get("latitude"),
            "longitude": d.get("longitude"),
            "score": float(scores[i][0]),
            "level": label_map[labels[i]]
        })

    return results