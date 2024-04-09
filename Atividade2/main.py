# def max_profit_cutting(n, l):
#     P = [0] * (n + 1)
#     for i in range(1, n + 1):
#         max_profit = float('-inf')
#         for j in range(1, i + 1):
#             max_profit = max(max_profit, l[j - 1] + P[i - j])
#         P[i] = max_profit
#     return P[n]
#
# # Exemplo de uso
# n = 8
# l = [1, 5, 8, 9, 10, 17, 17, 20]
# print("Lucro máximo:", max_profit_cutting(n, l))


# def max_profit_cutting_recursive(n, l, k):
#     if n == 0:
#         return 0, [], k
    
#     max_profit = float('-inf')
#     best_cut = None
    
#     for i in range(1, n + 1):
#         profit, cuts,k = max_profit_cutting_recursive(n - i, l,k)
#         if l[i - 1] + profit > max_profit:
#             max_profit = l[i - 1] + profit
#             best_cut = [i] + cuts
#         k += 1
#     return max_profit, best_cut, k 

def max_profit_cutting(n, l):
    # Inicializa uma lista para armazenar o lucro máximo para cada tamanho de barra
    profits = [0] * (n + 1)
    # Inicializa uma lista para armazenar os cortes ótimos para cada tamanho de barra
    cuts = [[] for _ in range(n + 1)]
    # Inicializa uma variável para contar o número de iterações
    iterations = 0

    # Para cada tamanho de barra de 1 até n
    for i in range(1, n + 1):
        max_profit = float('-inf')
        best_cut = None
        # Tenta todos os cortes possíveis de 1 até i
        for j in range(1, i + 1):
            # Calcula o lucro total como o lucro do corte atual mais o lucro máximo do restante da barra
            profit = l[j - 1] + profits[i - j]
            iterations += 1
            if profit > max_profit:
                max_profit = profit
                best_cut = [j] + cuts[i - j]
        # Armazena o lucro máximo e os cortes ótimos para o tamanho atual
        profits[i] = max_profit
        cuts[i] = best_cut

    return profits[n], cuts[n], iterations

# Exemplo de uso
n = 4
l = [4, 8, 13, 15]
profit, cuts, iterations = max_profit_cutting(n, l)
print("Lucro máximo:", profit)
print("Cortes:", cuts)
print("Número de iterações:", iterations)




# # Exemplo de uso
# n = 4
# l = [4, 8, 13, 15]
# k = 0
# profit, cuts, k = max_profit_cutting_recursive(n, l, k)
# print("Lucro máximo:", profit)
# print("Cortes:", cuts)
# print(f'Numero de iteracoes: {k}')

