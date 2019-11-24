#!/bin/bash
echo -e "Escriba un nombre para el Redireccionador SSL"
read -p ": " nombressl
echo -e "Escriba el puerto del Servicio a enlazar"
read -p ": " portserv
echo -e "Escriba el Nuevo Puerto SSL"
read -p ": " portssl
if lsof -Pi :$portssl -sTCP:LISTEN -t >/dev/null ; then
    echo "Ya esta en uso ese puerto"
else
echo "[$nombressl] " >> /etc/stunnel/stunnel.conf
echo "cert = /etc/stunnel/stunnel.pem " >> /etc/stunnel/stunnel.conf 
echo "accept = $portssl " >> /etc/stunnel/stunnel.conf 
echo "connect = 127.0.0.1:$portserv" >> /etc/stunnel/stunnel.conf 
sleep 5
echo "Reiniciando Servicio : Stunnel4"
service stunnel4 restart 1> /dev/null 2> /dev/null
fi
