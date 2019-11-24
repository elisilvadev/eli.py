import threading
import paramiko
import subprocess


#we defined a function to connect,and execute our command
 def ssh_comm(ip, usr, passwd, cmd):
     client = paramiko.SSHClient()
 #
 client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 client.connect(ip, username=user, password=passwd)
 ssh_session = client.get_transport().open_session()
 if ssh_session.active:
     ssh_session.exec_command(command)
     print ssh_session.recv(1024)
    return


#here we took the requerid values from the user
ip = raw_input("[*] Enter Server IP Andress \n")
usr = raw_input("[*] Enter Server User Name \n")
passwd = raw_input("[*]Enetr Server User Password \n")
cmd = raw_input("[*] Enetr Command to execute \n")

#here we called the function to connect and execute
ssh_command(ip, usr, passwd, cmd)