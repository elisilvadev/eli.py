print("__________,,MENU,,_________")
print("\n\n")
print("__internet da vivo digite __1__\n__internet da NET VIRTUAL digite __2__\n__internet por SSID __3__")
print("\n")


f=input("digite aqui: ")
if f=="3":
	ssid=input("digite aqui o SSID:")
	a="0"
	cont=0
	#### normal
	with open ("foda.txt", "w")as stream:
		while  cont < 9:
			cont = cont+1
			print(ssid+a*4+str(cont),file = stream)
		while  cont < 99:
			cont = cont+1
			print(ssid+a*3+str(cont),file = stream)
		while  cont < 99:
			cont = cont+1
			print(ssid+a*2+str(cont),file = stream)
		while  cont < 99:
			cont = cont+1
			print(ssid+a+str(cont),file = stream)		
	########## invertido
	
	with open ("foda.txt", "a")as stream:
		while  cont < 9:
			cont = cont+1
			print(a*4+str(cont)+ssid,file = stream)
		while  cont < 99:
			cont = cont+1
			print(a*3+str(cont)+ssid,file = stream)
		while  cont < 99:
			cont = cont+1
			print(ssid+a*2+str(cont),file = stream)
		while  cont < 99:
			cont = cont+1
			print(ssid+a+str(cont),file = stream)
	##### normal		
	with open ("foda.txt", "a")as stream:
		for base in range(9999,0,-1):
			print('%s\n%s\n%s' %(ssid.upper()+str(base),ssid+str(base),ssid.upper().capitalize()+str(base)),file = stream)
			
	####### invertido
	
	with open ("foda.txt", "a")as stream:
		for base in range(9999,0,-1):
			print('%s\n%s\n%s' %(str(base)+ssid.upper(),str(base)+ssid,str(base)+ssid.upper().capitalize()),file = stream)
	with open ("foda.txt","a")as stream:
		for kk in range(1980,2020):
			print(ssid+str(kk),file=stream)
			exit()

#####___vivo

if f=='1':
	key=input("Digite os 4 ultimos digitos do SSID: ") 
Alfa2=('A','B','C','D','E','F','0','1','2','3','4','5','6','7','8','9')
Nums=list('0123456789')
with open ("VIVO.txt", "w")as stream:
	for i1 in (Alfa2):
		for i2 in (Alfa2):
			for i3 in (Alfa2):
				for i4 in (Alfa2):
					for i5 in (Alfa2):
						for i6 in (Alfa2):
							y=(i1+i2+i3+i4+i5+i6)
							print(str(y)+key,file = stream)