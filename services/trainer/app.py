from flask import Flask, jsonify
import mnist_model

app = Flask(__name__)

@app.route("/train", methods=["POST"])
def train():
    mnist_model.train_mnist_model()
    return jsonify({"message": "Training started and completed successfully"}), 200

@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
