""""
Atividade 1 - Area de um Poligono Convexo - IA525
Nome: Jitesh Ashok Manilal Vassaram
RA: 175867

"""

from random import uniform
import matplotlib.pyplot as plt
from Atividade1 import p_inside

# Definindo as entradas do Simulador Monte Carlo
sim = 10000  # Numero de simulacoes
pol = 0     # Numero de pontos dentro do poligono

# Vertices de triangulo
# vert_x = (0.2, 0.2, 0.8)
# vert_y = (0.3, 0.8, 0.3)

# Vertices de quadrilatero
# vert_x = (0.2, 0.5, 0.8, 0.7)
# vert_y = (0.1, 0.8, 0.6, 0.3)

# Vertices do poligono especial
# vert_x = (0.623, 0.9279, 0.6410, 0.2153, 0.0119)
# vert_y = (0.9478, 0.9185, 0.1372, 0.1420, 0.4632)

# Vertices do poligono nao convexo
vert_x = (0.1, 0.3, 0.6, 0.8, 0.4)
vert_y = (0.9, 0.7, 0.8, 0.4, 0.1)


n = len(vert_x)     # Contagem do numero de vertices/arestas

# Simulacao Monte Carlo para gerar os pontos "x" e "y" simulados
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

    d = p_inside.dotprod(vert_x, vert_y, l_xs[j], l_ys[j], n)

    # Caso o ponto esteja dentro do poligono (d == True), soma-se +1 na variavel "pol" e armazena-se o ponto em uma
    # lista para plotagem das figuras
    if d:
        pol += 1
        pontos_polx.append(l_xs[j])
        pontos_poly.append(l_ys[j])
    else:
        pontos_quadx.append(l_xs[j])
        pontos_quady.append(l_ys[j])


# Printa a quantidade de pontos dentro do poligono e a area estimada
print(f'O numero de pontos dentro do poligono é de: {pol}')
print(f'O numero de pontos dentro do quadrado é de: {sim}')
print(f'A area do poligono sera: {pol/sim:.4f}')

# Inclusao do ultimo ponto para a geracao das figuras
lista_x = list(vert_x)
lista_y = list(vert_y)
lista_x.append(vert_x[0])
lista_y.append(vert_y[0])

vert_x = tuple(lista_x)
vert_y = tuple(lista_y)

# Figuras
plt.axhline(y=1, color='red', linestyle='--')
plt.axhline(y=0, color='red', linestyle='--')
plt.axvline(x=1, color='red', linestyle='--')
plt.axvline(x=0, color='red', linestyle='--')
plt.plot(vert_x, vert_y, 'k--')
plt.plot(vert_x, vert_y, 'go',ms=10)
plt.plot(pontos_polx, pontos_poly, 'bo', ms=2, label='Pontos dentro do Poligono')
plt.plot(pontos_quadx, pontos_quady, 'ro', ms=2, label='Pontos dentro do Quadrado')
plt.axis([-0.125, 1.125, -0.125, 1.125])
plt.legend(loc="upper right")
plt.grid(True)
plt.show()
