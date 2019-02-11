# -*- coding:utf-8 -*-
from celery import Celery
import time
broker = "redis://localhost:6379/1"
backend = "redis://localhost:6379/2"

# 第一个参数表示任务名称
# 第二个参数broker是指redis消息中间件
# 第三个参数backend用来存储任务执行的结果
app = Celery("my_task", broker=broker, backend=backend)


@app.task
def add(x, y):
    print "函数确认被调用"
    time.sleep(5)
    return x + y
