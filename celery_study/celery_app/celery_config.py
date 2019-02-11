# -*- coding:utf-8 -*-

BROKER_URL = "redis://localhost:6379/1"

CELERY_RESULT_BACKEND = "redis://localhost:6379/2"

CELERY_TIMEZONE = "Asia/Shanghai"  # 默认UTC

# 导入指定的任务模块
CELERY_IMPORTS = (
    "celery_app.task1",
    "celery_app.task2",
)