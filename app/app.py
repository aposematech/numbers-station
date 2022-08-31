#!/usr/bin/env python3.9

# https://docs.aws.amazon.com/lambda/latest/dg/python-handler.html
# https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html

import random
import string
import tweepy # https://docs.tweepy.org/en/stable/

# https://awslabs.github.io/aws-lambda-powertools-python/latest/
from aws_lambda_powertools.utilities import parameters

def get_alpha_only(text):
    return ''.join(filter(str.isalpha, text.upper()))

def get_one_time_pad(alpha, text):
    system_random = random.SystemRandom()
    return ''.join(system_random.choice(alpha) for i in range(len(text)))

def get_cipher_code(alpha, text, key):
    return ''.join(str((ord(a) - ord(b)) % len(alpha)).zfill(2) for a, b in zip(text, key))

def get_code_blocks(text, size):
    return ' '.join([text[i:i+size].ljust(size, '0') for i in range(0, len(text), size)])

def handler(event, context):
    # get code
    alphabet = string.ascii_uppercase
    plain_text = get_alpha_only("Be sure to drink your Ovaltine!") # https://youtu.be/6_XSShVAnkY
    one_time_pad = get_one_time_pad(alphabet, plain_text)
    cipher_code = get_cipher_code(alphabet, plain_text, one_time_pad)
    cipher_code_blocks = get_code_blocks(cipher_code, 5)
    # get secrets
    twitter_consumer_key = parameters.get_secret("twitter_consumer_key")
    twitter_consumer_secret = parameters.get_secret("twitter_consumer_secret")
    twitter_access_token = parameters.get_secret("twitter_access_token")
    twitter_access_token_secret = parameters.get_secret("twitter_access_token_secret")
    # post tweet
    client = tweepy.Client(
        consumer_key=twitter_consumer_key, 
        consumer_secret=twitter_consumer_secret, 
        access_token=twitter_access_token, 
        access_token_secret=twitter_access_token_secret)
    client.create_tweet(text=cipher_code_blocks)
    return { 
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": {
            "alphabet": alphabet,
            "plain_text": plain_text,
            "one_time_pad": one_time_pad,
            "cipher_code": cipher_code,
            "cipher_code_blocks": cipher_code_blocks
        }
    }
