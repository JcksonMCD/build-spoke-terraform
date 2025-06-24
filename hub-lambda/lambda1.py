import json


def lambda_handler(event, context):

    print("Welcome to Lambda 1")

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": '{"message": "Hello from Lambda1"}'
    }
