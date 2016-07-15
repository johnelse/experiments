#!/usr/bin/python
import socket
import sys

def findport():
    try:
        port = int(sys.argv[1]) 
    except Exception:
        print "Could not read port - defaulting to 8080."
        port = 8080
    return port

host = socket.gethostname()
port = findport()
sock = socket.socket()
sock.bind((host, port))

sock.listen(5)
print "Listening on port %d." % port
while True:
    c, addr = sock.accept()
    try:
        receiving = True
        while receiving:
            data = c.recv(1024)
            if len(data) > 0:
                print data
            else:
                receiving = false
    except Exception:
        print "Client closed connection."
    c.close()
