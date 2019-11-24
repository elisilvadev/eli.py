# -*- coding: utf-8 -*-
import socket, threading, select
    
def conecta(c, a):
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
    

# Listen
l = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
l.bind((str(''), int(8088)))
l.listen(0)
while True:
    c, a = l.accept()
    tarefa_conecta = threading.Thread( target=conecta, args=( c, a ) )
    tarefa_conecta.daemon = True
    tarefa_conecta.start()
l.close()