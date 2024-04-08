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
        return 0
    max_profit = float('-inf')
    for i in range(1, n + 1):
        max_profit = max(max_profit, l[i - 1] + max_profit_cutting_recursive(n - i, l))
    return max_profit


# Exemplo de uso
n = 4
l = [4, 8, 13, 15]
print("Lucro máximo:", max_profit_cutting_recursive(n, l))
