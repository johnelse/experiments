#!/usr/bin/python
import socket, sys, time

def getargs():
    host = sys.argv[1]
    port = int(sys.argv[2])
    return (host, port)

try:
    host, port = getargs()
except Exception:
    sys.exit("Could not read arguments.")

sock = socket.socket()
sock.connect((host, port))

try:
    while True:
        sock.send("Hullo thar!\n")
except Exception:
    print "Server closed connection."

sock.close()
