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


def max_profit_cutting_recursive(n, l):
    if n == 0:
        return 0, []
    
    max_profit = float('-inf')
    best_cut = None

    for i in range(1, n + 1):
        profit, cuts = max_profit_cutting_recursive(n - i, l)
        if l[i - 1] + profit > max_profit:
            max_profit = l[i - 1] + profit
            best_cut = [i] + cuts

    return max_profit, best_cut

# Exemplo de uso
n = 4
l = [4, 8, 13, 15]
profit, cuts = max_profit_cutting_recursive(n, l)
print("Lucro máximo:", profit)
print("Cortes:", cuts)
