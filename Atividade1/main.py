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
sim = 1000  # Numero de simulacoes
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
vert_x = (0.2, 0.8, 0.2)
vert_y = (0.3, 0.3, 0.8)

# Vertices de quadrilatero
# vert_x = (0.2, 0.5, 0.8, 0.7)
# vert_y = (0.1, 0.8, 0.6, 0.3)


# Preciso verificar se tem alguma solucao matricial para isso, sem precisar calcular separadamente
# m0 = (vert_y[1] - vert_y[0])/(vert_x[1] - vert_x[0])
# m1 = (vert_y[2] - vert_y[1])/(vert_x[2] - vert_x[1])
# m2 = (vert_y[3] - vert_y[2])/(vert_x[3] - vert_x[2])
# m3 = (vert_y[0] - vert_y[3])/(vert_x[0] - vert_x[3])
#
# n0 = vert_y[0] - m0 * vert_x[0]
# n1 = vert_y[1] - m1 * vert_x[1]
# n2 = vert_y[2] - m2 * vert_x[2]
# n3 = vert_y[3] - m3 * vert_x[3]

d = p_inside.p_inside(vert_x, vert_y, 0.442, 0.596, 3)

print(d)

plt.plot(vert_x, vert_y, 'k--')
plt.plot(vert_x,vert_y, 'go')
plt.plot(0.442, 0.596, 'go')
plt.axis([0, 1, 0, 1])
plt.grid(True)
plt.show()



# Monte Carlo Simulation
l_xs = []
l_ys = []

for i in range(sim):

    x = uniform(0, 1)
    l_xs.append(x)

    y = uniform(0, 1)
    l_ys.append(y)

