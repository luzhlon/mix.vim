import base64 as b64
import urllib.request as req
#培根编码表
bcode = { 'A': 'aaaaa', 'B': 'aaaab', 'C': 'aaaba',
          'D': 'aaabb', 'E': 'aabaa', 'F': 'aabab',
          'G': 'aabba', 'H': 'aabbb', 'I': 'abaaa',
          'J': 'abaab', 'K': 'ababa', 'L': 'ababb',
          'M': 'abbaa', 'N': 'abbab', 'O': 'abbba',
          'P': 'abbbb', 'Q': 'baaaa', 'R': 'baaab',
          'S': 'baaba', 'T': 'baabb', 'U': 'babaa',
          'V': 'babab', 'W': 'babba', 'X': 'babbb',
          'Y': 'bbaaa', 'Z': 'bbaab' }
#莫尔斯编码表
mcode = { 'A': '.-'    , 'B': '-...'  , 'C': '-.-.'  ,
          'D': '-..'   , 'E': '.'     , 'F': '..-.'  ,
          'G': '--.'   , 'H': '....'  , 'I': '..'    ,
          'J': '.---'  , 'K': '-.-'   , 'L': '.-..'  ,
          'M': '--'    , 'N': '-.'    , 'O': '---'   ,
          'P': '.--.'  , 'Q': '--.-'  , 'R': '.-.'   ,
          'S': '...'   , 'T': '-'     , 'U': '..-'   ,
          'V': '...-'  , 'W': '.--'   , 'X': '-..-'  ,
          'Y': '-.--'  , 'Z': '--..'  ,

          '0': '-----' , '1': '.----' , '2': '..---' ,
          '3': '...--' , '4': '....-' , '5': '.....' ,
          '6': '-....' , '7': '--...' , '8': '---..' ,
          '9': '----.' }
# morse encode
def morse(dat):
    ret = []
    ss = dat.upper()
    for k in ss:
        ret.append(mcode[k] if k in mcode else k)
    return ' '.join(ret)
# base64 encode
def base64(dat):
    dat = dat.encode() if type(dat) is str else dat
    return b64.b64encode(dat).decode()
# url encode
url = req.quote
