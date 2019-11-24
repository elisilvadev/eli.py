# -*- coding: utf-8 -*-
import socket, threading, select

try:
    import os
    os.system('@echo off & mode 50,20 & title TCP Over DropBear Tunnel v1.0 & color 47')
except:
    pass
    
def conecta(c, a):
    print(f'[#] Receiving Client {a[-1]}')

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((str('fr-2.serverip.co'), int(80)))

    # Cliente Nao Suporta Proxy.
    s.send(b"GET http://portalrecarga.vivo.com.br/recarga/home/ HTTP/1.1\r\n\r\n")

    try:
        while True:
            r, w, x = select.select([c,s], [], [c,s], 3)
            if x: raise
            for i in r:
                data = i.recv(8192)
                # Raise if not data.
                if not data: raise
                if i is s:
                    # Download.
                    c.send(data)
                else:
                    # Upload.
                    s.send(data)
    except:
        pass
    
    c.close()
    s.close()
    print(f'[!] Client {a[-1]} Disconnected!')
    
print('TCP Over DropBear Tunnel v1.0')
print('Created by: Marcone')
# Listen
l = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
l.bind((str(''), int(8088)))
l.listen(0)
while True:
    c, a = l.accept()
    tarefa_conecta = threading.Thread( target = conecta, args = ( c, a ) )
    tarefa_conecta.daemon = True
    tarefa_conecta.start()
l.close()