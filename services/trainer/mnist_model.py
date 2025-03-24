import os
import tensorflow as tf
from tensorflow import keras

MODEL_PATH = "/mnt/model/mnist_cnn.h5"  # We'll mount a PVC on /mnt/model

def train_mnist_model():
    # Download MNIST dataset
    (x_train, y_train), (x_test, y_test) = keras.datasets.mnist.load_data()
    x_train = x_train / 255.0
    x_test = x_test / 255.0

    # Expand dims to (N, 28, 28, 1)
    x_train = x_train[..., None]
    x_test  = x_test[..., None]

    model = keras.Sequential([
        keras.layers.Conv2D(32, kernel_size=(3,3), activation='relu', input_shape=(28,28,1)),
        keras.layers.Conv2D(64, (3,3), activation='relu'),
        keras.layers.MaxPooling2D(pool_size=(2,2)),
        keras.layers.Flatten(),
        keras.layers.Dense(128, activation='relu'),
        keras.layers.Dense(10, activation='softmax')
    ])

    model.compile(loss="sparse_categorical_crossentropy",
                  optimizer="adam",
                  metrics=["accuracy"])

    model.fit(x_train, y_train, batch_size=128, epochs=1, validation_split=0.1)

    test_loss, test_acc = model.evaluate(x_test, y_test)
    print(f"Test accuracy: {test_acc:.4f}")

    # Ensure model directory
    os.makedirs(os.path.dirname(MODEL_PATH), exist_ok=True)
    model.save(MODEL_PATH)
    print(f"Model saved at: {MODEL_PATH}")
