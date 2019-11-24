#-*-coding:utf8;-*-
#qpy:3
#qpy:console

print("This is console module")
#imc 3.0
'''tabela imc 2.0
<18.5 = abaixo do peso
18.6 - 24.9 = saudável
25.0 - 29.9 = excesso de peso
30.0 - 34.9 = obesidade 1
35.0 - 39.9 = obesidade 2
>40.0 = obesidade 3'''
user=input('bom gostaria de saber seu nome')
print('bem vindo',user)
Imc=int(input('agora só preciso saber seu imc'))
if Imc <= 18.5:
    while Imc <= 18.5:
      print(' Pareci que vc está abaixo do peso')
else:
   print('melhor do que agora, só amanhã')