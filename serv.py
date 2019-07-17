from xmlrpc.server import SimpleXMLRPCServer
import time
from socketserver import ThreadingMixIn


class ThreadXMLRPCServer(ThreadingMixIn, SimpleXMLRPCServer):
    pass

# 调用函数
def respon_string(dtype, data):
    print(dtype, data)
    if dtype == 'lbdns':
        print(111)
        return 111

if __name__ == '__main__':
    server = ThreadXMLRPCServer(('192.168.0.98', 8888), allow_none=True) # 初始化
    server.register_function(respon_string, "get_string") # 注册函数
    print("Listening for Client")
    server.serve_forever() # 保持等待调用状态

