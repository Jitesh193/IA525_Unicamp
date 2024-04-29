"""
Atividade 3 - Filtragem de Sinais
Jitesh Ashok Manilal Vassaram
RA: 175867
"""

import numpy as np
import matplotlib.pyplot as plt
import cvxpy 

np.random.seed(42)
n = 4
delta = np.zeros((n,n))

"Construcao da matriz Delta"
for i in range(n):
    for j in range(n):
        
        if i == j:
           if (i == 0) or (i == n):
              delta[i,j] = 1
           else:
              delta[i,j] = 2
        
        elif abs(i-j) == 1:
           delta[i,j] = -1

        else:
           delta[i,j] = 0

print(f'A matriz Delta é: \n {delta}')

"Numero de pontos do Sinal Senoidal"
num_pontos = 1000

"Sinal Senoidal"
t = np.linspace(0,5, num_pontos)
f = 1
sen = np.sin(2*np.pi*f*t)

"Ruido Gaussiano"
ruido = np.random.normal(0,np.sqrt(0.01), num_pontos)

"Sinal Final"
x_c = sen + ruido

"Plot do sinal"
plt.figure(figsize=(10, 6))
plt.plot(t, sen, label='Sinal Senoidal')
plt.plot(t, x_c, label='Sinal com Ruído Gaussiano')
plt.xlabel('Tempo')
plt.ylabel('Amplitude')
plt.title('Sinal Senoidal com Ruído Gaussiano')
plt.legend()
plt.grid(True)
plt.show()

"Utilizacao da biblioteca 'cvxpy' "

