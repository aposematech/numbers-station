#!/usr/bin/env python3.9

# https://docs.aws.amazon.com/lambda/latest/dg/python-handler.html
# https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html

import os
import qrcode # https://pypi.org/project/qrcode/
import random
import string
import json
import tweepy # https://docs.tweepy.org/en/stable/

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
    plain_text = get_alpha_only(parameters.get_secret(os.environ['SECRET_TRANSMISSION_NAME']))
    one_time_pad = get_one_time_pad(alphabet, plain_text)
    cipher_text = get_cipher_text_blocks(get_cipher_text(alphabet, plain_text, one_time_pad), 5)
    # create qrcode
    cipher_text_qr_code_filename = "/tmp/cipher_text_qr_code.png"
    cipher_text_qr_code = qrcode.make(cipher_text)
    cipher_text_qr_code.save(cipher_text_qr_code_filename)
    # get secrets
    twitter_consumer_key = parameters.get_secret(os.environ['TWITTER_CONSUMER_KEY_NAME'])
    twitter_consumer_secret = parameters.get_secret(os.environ['TWITTER_CONSUMER_SECRET_NAME'])
    twitter_access_token = parameters.get_secret(os.environ['TWITTER_ACCESS_TOKEN_NAME'])
    twitter_access_token_secret = parameters.get_secret(os.environ['TWITTER_ACCESS_TOKEN_SECRET_NAME'])
    # upload qrcode
    auth = tweepy.OAuth1UserHandler(
        twitter_consumer_key, 
        twitter_consumer_secret, 
        twitter_access_token, 
        twitter_access_token_secret)
    api = tweepy.API(auth)
    cipher_text_qr_code = api.media_upload(cipher_text_qr_code_filename)
    cipher_text_qr_code_media_ids = [cipher_text_qr_code.media_id_string]
    # tweet ciphertext and qrcode
    client = tweepy.Client(
        consumer_key=twitter_consumer_key, 
        consumer_secret=twitter_consumer_secret, 
        access_token=twitter_access_token, 
        access_token_secret=twitter_access_token_secret)
    client.create_tweet(text=cipher_text, media_ids=cipher_text_qr_code_media_ids)
    return { 
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "alphabet": alphabet,
            "plain_text": plain_text,
            "one_time_pad": one_time_pad,
            "cipher_text": cipher_text
        })
    }
