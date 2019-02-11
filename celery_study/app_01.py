# -*- coding:utf-8 -*-
from tasks import add

if __name__ == "__main__":
    print "start task..."
    result = add.delay(2, 8)
    print result
    print "enc task..."
