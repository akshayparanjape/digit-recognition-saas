import requests

def train_model():
    resp = requests.post("http://localhost:8081/train")
    print("Train response:", resp.text)

def predict_digit(dummy_pixels):
    payload = {"image_pixels": dummy_pixels}
    resp = requests.post("http://localhost:8082/predict", json=payload)
    print("Predict response:", resp.json())

def monitor_predictions():
    payload = {
        "predictions": [
            {"actual": 2, "predicted": 3},
            {"actual": 5, "predicted": 5},
            # Add more if you want
        ]
    }
    resp = requests.post("http://localhost:8083/monitor", json=payload)
    print("Monitor response:", resp.json())

if __name__ == "__main__":
    # Typically you'd run: kubectl port-forward ...
    train_model()

    # Prepare 784 zeros as a dummy input
    pixels = [0]*784
    predict_digit(pixels)

    monitor_predictions()
