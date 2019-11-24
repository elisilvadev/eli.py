log warning "Startando Configuracao do Script de Backup Automatico "

#Carregando variaveis Globais de Data e hora
#Data do MK
:global data [/system clock get date]
:global datetimestring ([:pick $data 0 3] ."-" . [:pick $data 4 6] ."-" . [:pick $data 7 11])
#Hora do MK
:global hora [/system clock get time]
:global temp ([:pick $hora 0 2].":".[:pick $hora 3 5].":".[:pick $hora 6 8])


#Executa o backup concatenando a data e hora atual
/system backup save name="$[/system identity get name]_$datetimestring_$temp" 
log message "backup finalizado...!"

#Executa a exportacao do arquivo rsc
/export compact file="$[/system identity get name]_$datetimestring_$temp"
log message "export finalizado...!"

:log warning "Por favor aguarde 10 segundos até iniciar a transferencia do arquivo!!!"
:delay 10s

:log warning "Iniciando o envio dos  arquivo de backup e rsc do Mikrotik via FTP...!!!"
#Inicia o envio do arquivo de backup
/tool fetch address=100.200.10.20 src-path="$[/system identity get name]_$datetimestring_$temp.backup" user=usuario password=123456 
port=21 upload=yes mode=ftp dst-path="$[/system identity get name]_$datetimestring_$temp.backup"
:log message "Arquivo de backup enviado"

:log warning "Aguarde até que o proximo arquivo seja enviado"
:delay 30s

:log warning "Iniciando o envio do proximo arquivo"
#Inicia o envio do arquivo de export
/tool fetch address=100.200.10.20 src-path="$[/system identity get name]_$datetimestring_$temp.rsc" user=usuario password=123456 
port=21 upload=yes mode=ftp dst-path="$[/system identity get name]_$datetimestring_$temp.rsc"
:log message "Arquivo de rsc enviado"

:log warning "Aguarde até que o processo seja encerrado...."
:delay 10s


:log warning "Apagando arquivos...."
:delay 10s
# Remove os arquivos de backup.
/file remove $[/system identity get name]_$datetimestring_$temp.backup
/file remove $[/system identity get name]_$datetimestring_$temp.rsc

:log info "Sistema de Backup Finalizado...!!!!"
