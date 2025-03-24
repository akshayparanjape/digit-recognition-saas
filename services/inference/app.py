from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
import os

MODEL_PATH = "/mnt/model/mnist_cnn.h5"

app = Flask(__name__)

# Load model at startup if it exists
model = None
if os.path.exists(MODEL_PATH):
    model = tf.keras.models.load_model(MODEL_PATH)
    print("Loaded model from", MODEL_PATH)
else:
    print("Warning: Model file not found. Please train first.")

@app.route("/predict", methods=["POST"])
def predict():
    global model
    if model is None:
        return jsonify({"error": "No model loaded. Train first."}), 400

    data = request.get_json()
    # Expect {"image_pixels": [... 784 values ...]} or similar
    pixels = data.get("image_pixels")
    if not pixels or len(pixels) != 784:
        return jsonify({"error": "Invalid input. Must have 784 pixel values."}), 400

    # Convert list to numpy array, shape to [1,28,28,1]
    arr = np.array(pixels).reshape((1, 28, 28, 1)).astype("float32")
    prediction = model.predict(arr)
    predicted_class = np.argmax(prediction[0])

    return jsonify({"predicted_class": int(predicted_class)})

@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
