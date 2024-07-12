clc;
clear;

%% Questao do tabuleiro
% Carregar a matriz M que representa o tabuleiro
M = [1 0 1 1 1
     1 0 1 0 1;
     0 0 1 0 0;
     1 0 0 1 1;
     0 1 0 1 0;
     1 1 0 1 0];

[m, n] = size(M);

% Construcao da matriz do tabuleiro que será modificada
M1 = zeros(m,n);
for i=1:m
    for j=1:n
        if M(i,j) ~= 0
            M1(i,j) = 1;
        else
            M1(i,j) = 0;
        end
    end
end

troca = zeros(m,n);

% Inicializar o CVX
cvx_begin
    cvx_solver mosek  % Usar o solver MOSEK
    variable x(m,n) binary  % matriz de inversoes
    variable trocas(m,n) integer    % Elementos dessa matriz indica quantas trocas foram feitas em cada celula
    
    % Função objetivo: minimizar o número de inversões
    minimize( sum(sum(x)) ) 
    
    % Restrições
    subject to
        for i=1:m
            for j=1:n
                if i > 1
                    trocas(i-1, j) == trocas(i-1, j) + x(i, j);
                end
                if i < m
                    trocas(i+1, j) == trocas(i+1, j) + x(i, j);
                end
                if j > 1
                    trocas(i, j-1) == trocas(i, j-1) + x(i, j);
                end
                if j < n
                    trocas(i, j+1) == trocas(i, j+1) + x(i, j);
                end
                trocas(i, j) == trocas(i, j) + x(i, j);

                if M1(i,j) == 0 && trocas(i,j)/2 ~= 0
                    x(i,j) == 1;
%                 elseif M1(i,j) == 1 && troca(i,j)/2 == 0  
                end
            end
        end


        
        
    
cvx_end

% Exibir a solução
X = x;
disp('Matriz de seleções:')
disp(X)

tabuleiro_final = M1;
disp('Tabuleiro Final:')
disp(tabuleiro_final)
