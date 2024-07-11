clc;
clear;

%% Problema do SUDOKU em PLI

% Definir o tabuleiro inicial (0 representa uma célula vazia)

tabela_inicial = [
    0 2 0 0 3 0 0 4 0;
    6 0 0 0 0 0 0 0 3;
    0 0 4 0 0 0 5 0 0;
    0 0 0 8 0 6 0 0 0;
    8 0 0 0 1 0 0 0 6;
    0 0 0 7 0 5 0 0 0;
    0 0 7 0 0 0 6 0 0;
    4 0 0 0 0 0 0 0 8;
    0 3 0 0 4 0 0 2 0;
];

% Parâmetros do problema
n = 9;

% Iniciar CVX
cvx_begin
    cvx_solver mosek
    variable X(n, n, n) binary

    % Objetivo (apenas para ajudar o solver a convergir mais rápido)
    minimize(0)

    subject to
    % Restrições de células preenchidas
    for i = 1:n
        for j = 1:n
            if tabela_inicial(i, j) ~= 0
                k = tabela_inicial(i, j);
                X(i, j, k) == 1;
            end
        end
    end

    % Cada célula deve ter exatamente um número
    for i = 1:n
        for j = 1:n
            sum(X(i, j, :)) == 1;
        end
    end

    % Cada número deve aparecer exatamente uma vez em cada linha
    for i = 1:n
        for k = 1:n
            sum(X(i, :, k)) == 1;
        end
    end

    % Cada número deve aparecer exatamente uma vez em cada coluna
    for j = 1:n
        for k = 1:n
            sum(X(:, j, k)) == 1;
        end
    end

    % Cada número deve aparecer exatamente uma vez em cada subgrade 3x3
    for I = 0:2
        for J = 0:2
            for k = 1:n
                sum(sum(X(3*I+1:3*I+3, 3*J+1:3*J+3, k))) == 1;
            end
        end
    end

    
cvx_end

% Extrair a solução
tabela_final = zeros(n, n);
for i = 1:n
    for j = 1:n
        for k = 1:n
            if X(i, j, k) > 0.5
                tabela_final(i, j) = k;
            end
        end
    end
end

disp('Tabuleiro resolvido:');
disp(tabela_final);
