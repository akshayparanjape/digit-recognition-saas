#!/usr/bin/env bash
set -e

# You can change these if your services are exposed differently
TRAINER_PORT=8081
INFERENCE_PORT=8082
MONITOR_PORT=8083

echo "----------------------------------------------------"
echo "📡 Starting port-forwarding for services..."
echo "----------------------------------------------------"

# Start port-forwarding in background
kubectl port-forward svc/trainer ${TRAINER_PORT}:80 > /dev/null 2>&1 &
TRAINER_PID=$!

kubectl port-forward svc/inference ${INFERENCE_PORT}:80 > /dev/null 2>&1 &
INFERENCE_PID=$!

kubectl port-forward svc/monitor ${MONITOR_PORT}:80 > /dev/null 2>&1 &
MONITOR_PID=$!

# Wait a few seconds for services to become available
sleep 5

echo "✅ Trainer service is accessible at http://localhost:${TRAINER_PORT}"
echo "✅ Inference service is accessible at http://localhost:${INFERENCE_PORT}"
echo "✅ Monitor service is accessible at http://localhost:${MONITOR_PORT}"
echo

echo "----------------------------------------------------"
echo "🚀 Triggering model training on Trainer service..."
echo "----------------------------------------------------"
curl -s -X POST http://localhost:${TRAINER_PORT}/train | jq .

echo "⏳ Waiting for model to be saved..."
sleep 100  # adjust time as needed


echo
echo "----------------------------------------------------"
echo "🔍 Sending dummy image to Inference service..."
echo "----------------------------------------------------"

# Dummy MNIST image - 28x28 = 784 zeros (simulating a blank digit)
DUMMY_IMAGE=$(python3 -c 'import json; print(json.dumps({"image_pixels": [0]*784}))')

curl -s -X POST http://localhost:${INFERENCE_PORT}/predict \
  -H "Content-Type: application/json" \
  -d "${DUMMY_IMAGE}" | jq .

echo
echo "----------------------------------------------------"
echo "📊 Sending prediction logs to Monitor service..."
echo "----------------------------------------------------"

MONITOR_DATA=$(cat <<EOF
{
  "predictions": [
    {"actual": 2, "predicted": 3},
    {"actual": 5, "predicted": 5},
    {"actual": 7, "predicted": 7},
    {"actual": 4, "predicted": 1}
  ]
}
EOF
)

curl -s -X POST http://localhost:${MONITOR_PORT}/monitor \
  -H "Content-Type: application/json" \
  -d "${MONITOR_DATA}" | jq .

echo
echo "----------------------------------------------------"
echo "✅ All API tests complete."
echo "----------------------------------------------------"

echo "🧹 Cleaning up port-forwards..."
kill $TRAINER_PID
kill $INFERENCE_PID
kill $MONITOR_PID
