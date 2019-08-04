import os
from glob import glob


class FileFilter:
    def __init__(self, *args):
        assert args, "路径不能为空"
        self.__path = args

    def __judge_path(self, path):
        if os.path.exists(path):
            pass
        else:
            return "路径不存在"


def glo():
    resDir = os.getcwd() + "/logfile"
    os.chdir(resDir)
    con = glob(pathname=r'*2018101904*')
    print(con)


if __name__ == "__main__":
    fil = FileFilter(11)
