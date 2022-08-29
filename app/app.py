#!/usr/bin/env python3.9

# https://docs.aws.amazon.com/lambda/latest/dg/python-handler.html
# https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html

import os
import random
import string
import tweepy # https://docs.tweepy.org/en/stable/

def get_alpha_only(text):
    return ''.join(filter(str.isalpha, text.upper()))

def get_one_time_pad(alpha, text):
    system_random = random.SystemRandom()
    return ''.join(system_random.choice(alpha) for i in range(len(text)))

def get_cipher_code(alpha, text, key):
    return ''.join(str((ord(a) - ord(b)) % len(alpha)).zfill(2) for a, b in zip(text, key))

def get_code_blocks(text, size):
    return ' '.join([text[i:i+size].ljust(size, '0') for i in range(0, len(text), size)])

def post_tweet(text):
    CONSUMER_KEY = os.environ['CONSUMER_KEY']
    CONSUMER_SECRET = os.environ['CONSUMER_SECRET']
    ACCESS_TOKEN = os.environ['ACCESS_TOKEN']
    ACCESS_TOKEN_SECRET = os.environ['ACCESS_TOKEN_SECRET']
    client = tweepy.Client(
        consumer_key=CONSUMER_KEY, 
        consumer_secret=CONSUMER_SECRET, 
        access_token=ACCESS_TOKEN, 
        access_token_secret=ACCESS_TOKEN_SECRET)
    client.create_tweet(text=text)

def handler(event, context):
    alphabet = string.ascii_uppercase
    plain_text = get_alpha_only("Be sure to drink your Ovaltine!") # https://youtu.be/6_XSShVAnkY
    one_time_pad = get_one_time_pad(alphabet, plain_text)
    cipher_code = get_cipher_code(alphabet, plain_text, one_time_pad)
    cipher_code_blocks = get_code_blocks(cipher_code, 5)
    # post_tweet(cipher_code_blocks)
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
