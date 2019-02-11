# -*- coding:utf-8 -*-
from celery_app import app
import time


@app.task
def multiply(x, y):
    time.sleep(5)
    return x * y
