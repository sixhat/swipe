#!/usr/bin/env python
"""Controlador da MEO Box para o terminal"""
import socket
import sys

TCP_IP = '192.168.1.64'  # Mude o IP para o da sua BOX
TCP_PORT = 8082
BUFFER_SIZE = 1024
cmds = {
    "p+": "33",
    "p-": "34",
    "v+": "175",
    "v-": "174",
    "power": "233",
    "ok": "13",
    "menu": "36",
    "left": "37",
    "up": "38",
    "right": "39",
    "down": "40",
    "back": "8",
    "screen": "27",
    "guia": "112",
    "videoc": "114",
    "i": "159",
    "switch": "156",
    "grava": "115",
    "stop": "123",
    "play": "119",
    "rec": "225",
    "prev": "117",
    "rev": "118",
    "forw": "121",
    "next": "122",
    "red": "140",
    "green": "141",
    "yellow": "142",
    "blue": "143",
    "mute": "173",
    "stripes": "111"
}


def help_comandos():
    """Listagem dos comandos disponíveis"""
    print("Comandos disponíveis:\n")
    print("  meo.py <canal|comando>")
    print("\tonde <comando> é um de:")
    print("\t", ", ".join(cmds.keys()))


if len(sys.argv) == 1:
    help_comandos()
    sys.exit(1)

cmd = str(sys.argv[1])

if cmd.isdigit():
    print("Changing to :", cmd)
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((TCP_IP, TCP_PORT))
    data = s.recv(BUFFER_SIZE).decode()
    for l in cmd:
        msg = "key="+str(ord(l))+"\n"
        s.sendall(msg.encode())
        data = s.recv(BUFFER_SIZE).decode()
    s.close()
elif cmd in cmds.keys():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((TCP_IP, TCP_PORT))
    data = s.recv(BUFFER_SIZE).decode()
    s.sendall(str("key="+cmds[cmd]+"\n").encode())
    data = s.recv(BUFFER_SIZE).decode()
    s.close()
    s = 0
else:
    help_comandos()
