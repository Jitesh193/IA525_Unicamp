"""
Atividade 3 - Filtragem de Sinais
Jitesh Ashok Manilal Vassaram
RA: 175867
"""

import numpy as np
import matplotlib.pyplot as plt
import cvxpy as cp

np.random.seed(42)
# n = 4
# delta = np.zeros((n,n))

# "Construcao da matriz Delta"
# for i in range(n):
#     for j in range(n):
        
#         if i == j:
#            if (i == 0) or (i == n-1):
#               delta[i,j] = 1
#            else:
#               delta[i,j] = 2
        
#         elif abs(i-j) == 1:
#            delta[i,j] = -1

#         else:
#            delta[i,j] = 0

# print(f'A matriz Delta é: \n {delta}')

"Numero de pontos do Sinal Senoidal"
num_pontos = 1000

"Sinal Senoidal"
t = np.linspace(0,5, num_pontos)
f = 0.4
sen = np.sin(2*np.pi*f*t)

"Sinal de onda quadrada"
quad = np.sign(np.sin(2*np.pi*f*t))

"Ruido Gaussiano"
ruido = np.random.normal(0,np.sqrt(0.01), num_pontos)

"Sinal Final"
x_c = sen + ruido
x_cq = quad + ruido

"Utilizacao da biblioteca 'cvxpy' "

u = cp.Variable(num_pontos)
D = np.zeros((num_pontos,num_pontos))
lmbda = 40000

# Construcao da matriz Delta
for i in range(num_pontos):
    for j in range(num_pontos):
        
        if i == j:
           if (i == 0) or (i == num_pontos-1):
              D[i,j] = 1
           else:
              D[i,j] = 2
        
        elif abs(i-j) == 1:
           D[i,j] = -1

        else:
           D[i,j] = 0

# Definicao da F.O. para o Sinal Senoidal
obj = cp.Minimize(cp.sum_squares(u-x_c) + lmbda*cp.sum_squares(D @ u))

# Definicao do problema de otimizacao
problem = cp.Problem(obj)

# Resolucao do problema
problem.solve()

# print(f'O valor da F.O. para Senoidal L2 é: {problem.value}')

# Plot dos graficos
fig, axs = plt.subplots(1,3,figsize=(12,6))
fig.suptitle(f'Resultado para \u03BB = {lmbda}') 
axs[0].plot(t,sen)
axs[0].set_title('Sinal Senoidal')
axs[0].set_xlabel('Tempo')
axs[0].set_ylabel('Amplitude')
axs[0].grid(True)
axs[1].plot(t,x_c)
axs[1].set_title('Sinal Senoidal com ruído')
axs[1].set_xlabel('Tempo')
axs[1].set_ylabel('Amplitude')
axs[1].grid(True)
axs[2].plot(t,u.value)
axs[2].set_title('Sinal Senoidal filtrado')
axs[2].set_xlabel('Tempo')
axs[2].set_ylabel('Amplitude')
axs[2].grid(True)
plt.tight_layout()
plt.show()


# Definicao da F.O. para o Sinal de Onda Quadrada
lmbda2 = 40000
obj = cp.Minimize(cp.sum_squares(u-x_cq) + lmbda2*cp.sum_squares(D @ u))

# Definicao do problema de otimizacao
problem = cp.Problem(obj)

# Resolucao do problema
problem.solve()

# print(f'O valor da F.O. para Quadrada L2 é: {problem.value}')

# Plot dos graficos
fig, axs = plt.subplots(1,3,figsize=(12,6))
fig.suptitle(f'Resultado para \u03BB = {lmbda2}')
axs[0].plot(t,quad,color='red')
axs[0].set_title('Sinal de Onda Quadrada')
axs[0].set_xlabel('Tempo')
axs[0].set_ylabel('Amplitude')
axs[0].grid(True)
axs[1].plot(t,x_cq,color='red')
axs[1].set_title('Sinal de Onda Quadrada com ruído')
axs[1].set_xlabel('Tempo')
axs[1].set_ylabel('Amplitude')
axs[1].grid(True)
axs[2].plot(t,u.value,color='red')
axs[2].set_title('Sinal de Onda Quadrada filtrado')
axs[2].set_xlabel('Tempo')
axs[2].set_ylabel('Amplitude')
axs[2].grid(True)
plt.tight_layout()
plt.show()


"Definicao da F.O. para o Sinal Senoidal usando LASSO"

u2 = cp.Variable(num_pontos)
aux = cp.Variable(num_pontos)
lmbda3 = 50

obj2 = cp.Minimize(cp.sum_squares(u2-x_c) + lmbda3*cp.sum(aux))

# Definicao de restricoes
res = [
   -aux <= D @ u2,
   D @ u2 <= aux,
   aux >=0
]

# Definicao do problema de otimizacao
problem2 = cp.Problem(obj2, res)

# Resolucao do problema
problem2.solve()

# print(f'O valor da F.O. para Senoidal L1 é: {problem2.value}')

# Plot dos graficos
fig, axs = plt.subplots(1,3,figsize=(12,6))
fig.suptitle(f'Resultado para \u03BB = {lmbda3}')
axs[0].plot(t,sen)
axs[0].set_title('Sinal Senoidal')
axs[0].set_xlabel('Tempo')
axs[0].set_ylabel('Amplitude')
axs[0].grid(True)
axs[1].plot(t,x_c)
axs[1].set_title('Sinal Senoidal com ruído')
axs[1].set_xlabel('Tempo')
axs[1].set_ylabel('Amplitude')
axs[1].grid(True)
axs[2].plot(t,u2.value)
axs[2].set_title('Sinal Senoidal filtrado')
axs[2].set_xlabel('Tempo')
axs[2].set_ylabel('Amplitude')
axs[2].grid(True)
plt.tight_layout()
plt.show()

"Definicao da F.O. para o Sinal de Onda Quadrada usando LASSO"

u2 = cp.Variable(num_pontos)
aux = cp.Variable(num_pontos)
lmbda4 = 500

obj2 = cp.Minimize(cp.sum_squares(u2-x_cq) + lmbda4*cp.sum(aux))

# Definicao de restricoes
res = [
   -aux <= D @ u2,
   D @ u2 <= aux,
   aux >=0
]

# Definicao do problema de otimizacao
problem2 = cp.Problem(obj2, res)

# Resolucao do problema
problem2.solve()

# print(f'O valor da F.O. para Quadrada L1 é: {problem2.value}')

# Plot dos graficos
fig, axs = plt.subplots(1,3,figsize=(12,6))
fig.suptitle(f'Resultado para \u03BB = {lmbda4}')
axs[0].plot(t,quad,color='red')
axs[0].set_title('Sinal de Onda Quadrada')
axs[0].set_xlabel('Tempo')
axs[0].set_ylabel('Amplitude')
axs[0].grid(True)
axs[1].plot(t,x_cq,color='red')
axs[1].set_title('Sinal de Onda Quadrada com ruído')
axs[1].set_xlabel('Tempo')
axs[1].set_ylabel('Amplitude')
axs[1].grid(True)
axs[2].plot(t,u2.value,color='red')
axs[2].set_title('Sinal de Onda Quadrada filtrado')
axs[2].set_xlabel('Tempo')
axs[2].set_ylabel('Amplitude')
axs[2].grid(True)
plt.tight_layout()
plt.show()
