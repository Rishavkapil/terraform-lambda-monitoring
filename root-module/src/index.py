import time


def handler(event, context):
    mode = event.get("mode")

    if mode == "timeout":
        time.sleep(40)  # Longer than the 30-second timeout

    elif mode == "memory":
        data = bytearray(190 * 1024 * 1024)

        for i in range(0, len(data), 4096):
            data[i] = 1  # Touch the pages so the memory is really used

    return {
        "statusCode": 200,
        "body": "ok"
    }
