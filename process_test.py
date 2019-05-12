import time
from multiprocessing import Process
import os


def run_proc(name):
    while True:
        print('Run child process %s (%s)...' % (name, os.getpid()))
        time.sleep(2)


if __name__ == '__main__':
    print('Parent process %s.' % os.getpid())
    p = Process(target=run_proc, args=('test',))
    print('Process will start.')
    p.start()
    print(os.getpid())

    print('Process end.')
