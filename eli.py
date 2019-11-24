import socket, threading, select

def conecta(c, a):
    print(f'[#] Cliente {a[1]} Recibido!')
    s = socket.socket (socket.AF_INET,socket.SOCK_STREAM)
    # s.connect((str('18.231.95.94'), int(8080))) #proxy
    s.connect((str('18.231.95.94'), int(443))) # ssh stunnel ssl.

    #wrap ssl
    import ssl
    ctx = ssl.SSLContext(ssl.PROTOCOL_SSLv23)
    s = ctx.wrap_socket(s, server_hostname=str("www.bing.com.br))


    # Proxy - Proxy
    # print(c.recv(8192))
    # s.send(b'CONNECT 18.231.95.94:443 HTTP)1.0\r\n\r\n') # Payload
    # print(s.recv(8192))
    # c.send(b"HTTP/1.1 200 Established\r\n\r\n")# Resposta 200 ok.

    # Proxy - SSH (Dropbear)
    # print(c.recv(8192))
    # s.send(b'CONNECT 18.231.95.94:80 HTTP/1.0\r\n\r\n') # payload.
    # c.send(b"HTTP/1.1 200 Established\r\n\r\n" #resposta 200 ok.

    # SSH - Proxy
    # s.send(b"HTTP/1.1 200 Established\r\n\r\n") # Payloa.