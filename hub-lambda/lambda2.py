import json


def lambda_handler(event, context):

    print("Welcome to Lambda 2")

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": '{"message": "Hello from Lambda 2"}'
    }

