def max_lucro_recursivo(n, l, k):
    if n == 0:
        return 0, [], k
    
    max_l = float('-inf')
    max_corte = None
    
    for i in range(1, n + 1):
        lucro, corte,k = max_lucro_recursivo(n - i, l,k)
        if l[i - 1] + lucro > max_l:
            max_l = l[i - 1] + lucro
            max_corte = [i] + corte
        k += 1
    return max_l, max_corte, k 


def max_lucro(n, l):
    # Inicializa uma lista para armazenar o lucro máximo para cada tamanho de barra
    lucros = [0] * (n + 1)
    # Inicializa uma lista para armazenar os cortes ótimos para cada tamanho de barra
    corte = [[] for _ in range(n + 1)]
    # Inicializa uma variável para contar o número de iterações
    k = 0

    # Para cada tamanho de barra de 1 até n
    for i in range(1, n + 1):
        max_lucro = float('-inf')
        max_corte = None
        # Tenta todos os cortes possíveis de 1 até i
        for j in range(1, i + 1):
            # Calcula o lucro total como o lucro do corte atual mais o lucro máximo do restante da barra
            lucro = l[j - 1] + lucros[i - j]
            k += 1
            if lucro > max_lucro:
                max_lucro = lucro
                max_corte = [j] + corte[i - j]
        # Armazena o lucro máximo e os cortes ótimos para o tamanho atual
        lucros[i] = max_lucro
        corte[i] = max_corte

    return lucros[n], corte[n], k

# Exemplo de uso
# n = 4
# l = [4, 8, 13, 15]
# k = 0
# lucro, corte, k = max_lucro_recursivo(n, l, k)
# print(f"Lucro máximo com recursao: {lucro}")
# print(f"Cortes com recursao: {corte}")
# print(f'Numero de iteracoes com recursao: {k}')

# print('--'*20)

# lucro, cortes, k = max_lucro(n, l)
# print(f"Lucro máximo sem recursao: {lucro}")
# print(f"Cortes sem recursao: {cortes}")
# print("Número de iterações sem recursao:", k)

# Teste proposto
n = 17
l = [8, 23, 24, 71, 71, 86, 97, 115, 117, 119, 123, 126, 130, 131, 132, 137, 145]
lucro, corte, k = max_lucro(n,l)
print(f'Lucro maximo: {lucro}')
print(f'Cortes: {corte}')
print(f'Numero de iteracoes: {k}')