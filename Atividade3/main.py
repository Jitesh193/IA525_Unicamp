"""
Atividade 3 - Filtragem de Sinais
Jitesh Ashok Manilal Vassaram
RA: 175867
"""

import numpy as np
# import cvxpy 


n = 4
delta = np.zeros((n,n))
# Construcao da matriz Delta
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
