""""

Será utilizado simulacao de Monte Carlo para gerar os pontos necessários!

Para isso, as entradas são os pontos sorteados uniformemente X e Y entre [0,1] e o número de simulações que serão feitas

Outra entrada seria os pontos do polígono que se deseja calcular a área (será utilizado no 2o loop)

https://medium.com/@whystudying/monte-carlo-simulation-with-python-13e09731d500

"""


# import numpy as np
from random import uniform
import matplotlib.pyplot as plt
from Atividade1 import p_inside

# Definindo as entradas do Simulador Monte Carlo
sim = 100  # Numero de simulacoes
quad = 0    # Numero de pontos dentro do quadrado
pol = 0     # Numero de pontos dentro do poligono


# Definindo os pontos do poligono

# n = int(input('Digite a quantidade de vertices: '))
# vert_x = []
# vert_y = []
#
# for c in range(1, n+1):
#
#     x = float(input(f'Digite o {c}o vertice em x: '))
#     y = float(input(f'Digite o {c}o vertice em y: '))
#
#     vert_x.append(x)
#     vert_y.append(y)
#
# print(vert_x)
# print(vert_y)

# Vertices de triangulo
# vert_x = (0.2, 0.2, 0.8)
# vert_y = (0.3, 0.8, 0.3)

# Vertices de quadrilatero
vert_x = (0.2, 0.5, 0.8, 0.7)
vert_y = (0.1, 0.8, 0.6, 0.3)

# Monte Carlo Simulation
l_xs = []
l_ys = []

for i in range(sim):

    x = uniform(0, 1)
    l_xs.append(x)

    y = uniform(0, 1)
    l_ys.append(y)


# Verificacao dos pontos dentro ou nao do poligono

pontos_polx = []
pontos_poly = []
pontos_quadx = []
pontos_quady = []

for j in range(sim):

    d = p_inside.dotprod(vert_x, vert_y, l_xs[j], l_ys[j], 3)

    if d:
        pol += 1
        pontos_polx.append(l_xs[j])
        pontos_poly.append(l_ys[j])
    else:
        quad += 1
        pontos_quadx.append(l_xs[j])
        pontos_quady.append(l_ys[j])

print(f'O numero de pontos dentro do poligono é de: {pol}')
print(f'O numero de pontos dentro do quadrado é de: {quad}')
print(f'A area do poligono sera: {pol/quad:.4f}')


lista_x = list(vert_x)
lista_y = list(vert_y)
lista_x.append(vert_x[0])
lista_y.append(vert_y[0])

vert_x = tuple(lista_x)
vert_y = tuple(lista_y)


plt.axhline(y=1, color='red', linestyle='--')
plt.axhline(y=0, color='red', linestyle='--')
plt.axvline(x=1, color='red', linestyle='--')
plt.axvline(x=0, color='red', linestyle='--')
plt.plot(vert_x, vert_y, 'k--')
plt.plot(vert_x, vert_y, 'go')
plt.plot(pontos_polx, pontos_poly, 'bo', ms=2, label='Pontos dentro do Poligono')
plt.plot(pontos_quadx, pontos_quady, 'ro', ms=2, label='Pontos dentro do Quadrado')
plt.axis([-0.125, 1.125, -0.125, 1.125])
plt.legend(loc="upper right")
plt.grid(True)
plt.show()
