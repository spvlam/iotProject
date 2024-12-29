import time
import random
import paho.mqtt.client as mqtt

# MQTT Configuration
MQTT_SERVER = "192.168.43.44"
MQTT_PORT = 1883

# Topics
userName = "user1"
equipmentId = "a96296b9-c500-11ef-bd39-0242ac170002"
tp = f"{userName}/{equipmentId}"
tpS = f"{userName}/SCRIPT"
subTemp = f"{equipmentId}\\TEMPERATURE"
subCurrent = f"{equipmentId}\\CURRENT"

# Fake sensor data generation
def get_fake_temperature():
    return round(random.uniform(20.0, 35.0), 2)  # Random temperature between 20.0 and 35.0

def get_fake_current():
    return round(random.uniform(0.5, 5.0), 2)  # Random current between 0.5 and 5.0

# MQTT Callbacks
def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected to MQTT Broker!")
        client.subscribe([(tp, 0), (tpS, 0)])  # Subscribe to topics
    else:
        print(f"Failed to connect, return code {rc}")

def on_message(client, userdata, msg):
    print(f"Received message: {msg.payload.decode()} from topic: {msg.topic}")

# Initialize MQTT Client
client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

try:
    client.connect(MQTT_SERVER, MQTT_PORT, 60)
except Exception as e:
    print(f"Failed to connect to MQTT Broker: {e}")
    exit(1)

# Start the MQTT Client Loop
client.loop_start()

try:
    while True:
        # Generate fake sensor data
        temperature = get_fake_temperature()
        current = get_fake_current()

        # Publish sensor data to respective topics
        client.publish(subTemp, str(temperature))
        client.publish(subCurrent, str(current))

        print(f"Published Temperature: {temperature}°C to {subTemp}")
        print(f"Published Current: {current}A to {subCurrent}")

        time.sleep(2)  # Delay between readings
except KeyboardInterrupt:
    print("Disconnecting from MQTT Broker...")
    client.loop_stop()
    client.disconnect()
