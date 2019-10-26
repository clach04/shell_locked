#!/usr/bin/env python3

import os
import socket
import stat
import sys


HOST = ''                 # Symbolic name meaning the local host
PORT = 50007              # Arbitrary non-privileged port

def listen_and_save(filename, port=PORT):
    print('Listening on tcp://127.0.0.1:%d' % port)
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind((HOST, port))
    s.listen(1)
    conn, addr = s.accept()
    print('Connected by', addr)

    key = []
    while 1:
        data = conn.recv(1024)
        if not data: break
        key.append(data)
        #print('got: %r' % data)
        conn.send(data)
    conn.close()
    k = b''.join(key)
    print('Entire key: %r' % k)

    filename = 'temp.key'
    print('Write key to %s?' % filename)
    comment = input('additional comment (CTRL-C cancel): ')
    if comment:
        comment = ' ' + comment + '\n'
        comment = comment.encode('utf-8')  # may not be ideal encoding
        k = k.replace(b'\n', b'')

    f = open(filename, 'ab')
    f.write(k)
    if comment:
        f.write(comment)
    f.close()
    # ensure same filemode that sshd expects for ~/.ssh/authorized_keys
    os.chmod(filename, stat.S_IRUSR | stat.S_IWUSR)
    print('Done, wrote key to %s' % filename)


if __name__ == "__main__":
    argv = sys.argv

    try:
        key_filename = argv[1]
    except IndexError:
        key_filename = 'temp.key'  # or ~/.ssh/authorized_keys

    listen_and_save(key_filename)  # only listens once

