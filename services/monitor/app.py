from flask import Flask, request, jsonify
import numpy as np

app = Flask(__name__)

# Keep track of running accuracy
predictions_count = 0
correct_count = 0

@app.route("/monitor", methods=["POST"])
def monitor():
    global predictions_count, correct_count

    data = request.get_json()
    # Expect format: {"predictions":[{"actual":2,"predicted":3}, ...]}
    preds = data.get("predictions", [])
    for p in preds:
        actual = p.get("actual")
        predicted = p.get("predicted")
        predictions_count += 1
        if actual == predicted:
            correct_count += 1

    if predictions_count > 0:
        accuracy = correct_count / predictions_count
    else:
        accuracy = 1.0

    # Simple logic: if accuracy < 0.9, suggest re-training
    needs_retraining = accuracy < 0.9

    response = {
        "total_predictions": predictions_count,
        "correct_predictions": correct_count,
        "accuracy": accuracy,
        "needs_retraining": needs_retraining
    }
    return jsonify(response)

@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
