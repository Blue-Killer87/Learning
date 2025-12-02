#!/bin/python

from flask import Flask

app = Flask(__name__)

@app.route("/hello/<name>")
def hello():
    return "Hello, World!"
