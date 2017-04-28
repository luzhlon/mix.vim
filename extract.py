# FileName: extract.py
import os, sys
import shutil, glob

# key为插件名称，value为依赖的文件列表
# 列表中的元组为插件所依赖的插件列表
plugs = {
    'popup.vim': ['*/popup.vim'],
    'dict.vim' : ['autoload/dict.vim',
                  'dict/*'],
    'proc.vim' : ['autoload/proc.vim',
                  'plugin/pylib.vim',
                  'pylib/proc.py'],
    'ctf.vim'  : ['autoload/ctf/*',
                  'plugin/pylib.vim',
                  'pylib/ctf/*'],
    'job.vim'  : ['autoload/job/*',
                  'autoload/job.vim'],
    'xmake.vim': [('job.vim', ),
                  'autoload/putconfig.lua',
                  'plugin/xmake.vim',
                  'autoload/xmake.vim']
}
# 检查路径目录是否存在，若不存在则创建
def check_dir(path):
    p = os.path.split(path)[0]
    if not os.path.isdir(p):
        os.makedirs(p)
# 复制文件到指定路径
def copy_file(src, dst):
    check_dir(dst)
    shutil.copy(src, dst)
# 将插件复制到指定目录
def copy_plugin(plugin, todir):
    for item in plugin:
        if type(item) is tuple:
            for p in item:
                copy_plugin(p, todir)
            continue
        for file in glob.glob(item):
            copy_file(file, todir + '/' + file)

plugin_name = ''
args_index = 0
# 从shell参数里找到一个插件名字
def find_plugin():
    global plugin_name, args_index
    n = 0
    for i in sys.argv:
        if i in plugs:
            plugin_name = i
            args_index  = n
            return 1
        n += 1

if find_plugin():
    plugin = plugs[plugin_name]
    try:
        todir = sys.argv[args_index + 1]
        copy_plugin(plugin, todir)
        print('complete!')
    except IndexError:
        for f in plugin:
            print(glob.glob(f))
