# -*- coding: utf-8 -*-
import socket
import thread
import string
import select

banner = """\033[1;36m                                   
 _____ _____ _____ _____ _         
|   __|   __|  |  |  _  | |_ _ ___ 
|__   |__   |     |   __| | | |_ -|
|_____|_____|__|__|__|  |_|___|___|
"""
print(banner)
print ("\033[1;36m=========[ \033[1;31mPROXY INJETOR \033[1;36m]=========\n")
print ('\033[1;32m'+'Adicione as seguintes informações\nabaixo para a execução do Script..'+'\033[0m\n')

BIND_ADDR = '127.0.0.1'
BIND_PORT = 8989
#PROXY
PROXT_ADDR = raw_input ("\033[1;33mProxy\033[0m: ")
#PORTA
PROXY_PORT = 80
#PAYLOAD
PAYLOAD = 'CONNECT [host_port][delay_split][crlf]PUT /? HTTP/1.1[crlf]Host: m.youtube.com.br[crlf]'
TAM_BUFFER = 16384
MAX_CLIENT_REQUEST_LENGTH = 32768 * 8 

def getReplacedPayload(payload, netData, hostPort, protocol):
	str = payload.replace('[netData]', netData)
	str = str.replace('[host_port]', (hostPort[0] + ':' + hostPort[1]))
	str = str.replace('[host]', hostPort[0])
	str = str.replace('[port]', hostPort[1])
	str = str.replace('[protocol]', protocol)
	str = str.replace('[crlf]', '\r\n')
	return str

def getRequestProtocol(request):
	inicio = request.find(' ', request.find(':')) + 1
	str = request[inicio:]
	fim = str.find('\r\n')
	
	return str[:fim]

def getRequestHostPort(request):
	inicio = request.find(' ') + 1
	str = request[inicio:]
	fim = str.find(' ')
	
	hostPort = str[:fim]
	
	return hostPort.split(':')

def getRequestNetData(request):
	return request[:request.find('\r\n')]

def receiveHttpMsg(socket):
	len = 1
	
	data = socket.recv(1)
	while data.find('\r\n\r\n'.encode()) == -1:
		if not data: break
		data = data + socket.recv(1)
		len += 1
		if len > MAX_CLIENT_REQUEST_LENGTH: break
	
	return data
	
def doConnect(clientSocket, serverSocket, tamBuffer):
	sockets = [clientSocket, serverSocket]
	timeout = 0
	print '\033[1;32mProxy conectado !\033[0m'
		
	while 1:
		timeout += 1
		ins, _, exs = select.select(sockets, [], sockets, 3)
		if exs: break
		
		if ins:
			for socket in ins:
				try:
					data = socket.recv(tamBuffer)
					if not data: break;
					
					if socket is serverSocket:
						clientSocket.sendall(data)
					else:
						serverSocket.sendall(data)

					timeout = 0
				except:
					break

		if timeout == 1800: break
	
def acceptThread(clientSocket, clientAddr):
	print '\033[1;33mInjetando Proxy\033[0m'
	
	request = receiveHttpMsg(clientSocket)
	
	if not request.startswith('CONNECT'):
		print '\033[1;33mRequer o metodo CONNECT!\033[0m'
		clientSocket.sendall('HTTP/1.1 405 Only_CONNECT_Method!\r\n\r\n')
		clientSocket.close()
		thread.exit()
	
	netData = getRequestNetData(request)
	protocol = getRequestProtocol(request)
	hostPort = getRequestHostPort(netData)
	finalRequest = getReplacedPayload(PAYLOAD, netData, hostPort, protocol)
	proxySocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	
	proxySocket.connect((PROXT_ADDR, PROXY_PORT))
	proxySocket.sendall(finalRequest)
	proxyResponse = receiveHttpMsg(proxySocket)
	
	print '\033[1;33m! ' + getRequestNetData(proxyResponse)
	clientSocket.sendall(proxyResponse)

	if proxyResponse.find('200 ') != -1:
		doConnect(clientSocket, proxySocket, TAM_BUFFER)
	
	print '\033[1;31mConexão perdida !\n\033[1;33mAguardando Requisição...\033[0m'
	proxySocket.close()
	clientSocket.close()
	thread.exit()

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind((BIND_ADDR, BIND_PORT))
server.listen(1)

print '\n\033[1;33mProxy em Execução...\033[0m'

while True:
	clientSocket, clientAddr = server.accept()
	thread.start_new_thread(acceptThread, tuple([clientSocket, clientAddr]))
	
server.close()
