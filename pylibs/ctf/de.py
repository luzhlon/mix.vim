from . import en
import codecs as cs
import re, base64 as b64
import urllib.request as req

codem, codeb = {}, {}
for k in en.mcode:
    codem[en.mcode[k]] = k
for k in en.bcode:
    codeb[en.bcode[k]] = k
# 培根解密
def bacon(dat):
    l = []
    for i in range(0, len(dat), 5):
        k = dat[i: i+5].lower()
        l.append(k in codeb and codeb[k] or ' '+k+' ')
    return ''.join(l)
# morse decode
def morse(dat):
    l = re.split('\s+', dat)
    ret = []
    for i in l:
        ret.append(i in codem and codem[i] or ' '+i+' ')
    return ''.join(ret)
# base64 decode
def base64(dat):
    dat = dat.encode() if type(dat) is str else dat
    return b64.b64decode(dat).decode()
# url decode
url = req.unquote
# 栅栏解码
def fence(dat, n):
    l = []
    for i in range(0, n):
        for j in range(i, len(dat), n):
            l.append(dat[j])
    return ''.join(l)
# rot13解码
def rot13(dat):
    return cs.encode(dat, 'rot13')
