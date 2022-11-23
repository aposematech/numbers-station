#!/usr/bin/env python3.9

# https://docs.aws.amazon.com/lambda/latest/dg/python-handler.html
# https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html

import boto3
import json
import os
import random
import requests
import string
import uuid

import qrcode # https://pypi.org/project/qrcode/

# https://awslabs.github.io/aws-lambda-powertools-python/latest/
from aws_lambda_powertools.utilities import parameters

def get_alpha_only(text):
    return ''.join(filter(str.isalpha, text.upper()))

def get_one_time_pad(alpha, text):
    system_random = random.SystemRandom()
    return ''.join(system_random.choice(alpha) for i in range(len(text)))

def get_cipher_text(alpha, text, key):
    return ''.join(str((ord(a) - ord(b)) % len(alpha)).zfill(2) for a, b in zip(text, key))

def get_cipher_text_blocks(text, size):
    return ' '.join([text[i:i+size].ljust(size, '0') for i in range(0, len(text), size)])

def handler(event, context):
    # encrypt plaintext
    alphabet = string.ascii_uppercase
    plain_text = get_alpha_only(parameters.get_parameter(name=os.environ['SECRET_TRANSMISSION_NAME'], decrypt=True))
    one_time_pad = get_one_time_pad(alphabet, plain_text)
    cipher_text = get_cipher_text_blocks(get_cipher_text(alphabet, plain_text, one_time_pad), 5)
    # create qrcode
    cipher_text_qr_code_filename = str(uuid.uuid4()) + ".png"
    cipher_text_qr_code_filepath = "/tmp/" + cipher_text_qr_code_filename
    cipher_text_qr_code = qrcode.make(cipher_text)
    cipher_text_qr_code.save(cipher_text_qr_code_filepath)
    # upload qrcode
    s3_client = boto3.client('s3')
    with open(cipher_text_qr_code_filepath, "rb") as f:
        s3_client.upload_fileobj(f, os.environ['WEBSITE_BUCKET_NAME'], os.environ['BUCKET_FOLDER_NAME'] + "/" + cipher_text_qr_code_filename)
    # ping heartbeat monitor
    requests.get(os.environ['HEARTBEAT_MONITOR_URL'])
    # return key only
    return { 
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "one_time_pad": one_time_pad
        })
    }
