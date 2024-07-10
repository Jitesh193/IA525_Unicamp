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
tab_fin = zeros(m,n);
for i=1:m
    for j=1:n
        if M(i,j) ~= 0
            tab_fin(i,j) = 1;
        else
            tab_fin(i,j) = 0;
        end
    end
end

x = zeros(m,n);
% Inicializar o CVX
cvx_begin
    cvx_solver mosek  % Usar o solver MOSEK
    variable inver(m,n) binary% numero de inversoes
    
    % Função objetivo: minimizar o número de inversões
    minimize( sum(sum(inver)) )
    
    % Restrições
    subject to
        for i=1:m

            if sum(tab_fin(i,:)) < 9

                for j=1:n
                    
                    if j>=2 && tab_fin(i,j-1) == 0 && tab_fin(i,j) == 0
                        inver(i,j) ==  1
                        x(i,j) = 1;
                        if i>1
                            if tab_fin(i-1,j) == 0
                                tab_fin(i-1,j) = 1;
                            else
                                tab_fin(i-1,j) = 0;
                            end
                        end
                        if i < m
                            if tab_fin(i+1,j) == 0
                                tab_fin(i+1,j) = 1;
                            else
                                tab_fin(i+1,j) = 0;
                            end
                        end
                        if j>1
                            if tab_fin(i,j-1) == 0
                                tab_fin(i,j-1) = 1;
                            else
                                tab_fin(i,j-1) = 0;
                            end
                        end
                        if j<n
                            if tab_fin(i,j+1) == 0
                                tab_fin(i,j+1) = 1;
                            else
                                tab_fin(i,j+1) = 0;
                            end
                        end
                    elseif i > 1 && tab_fin(i,j) == 0 && tab_fin(i-1,j) == 0
                        inver(i,j) == 1;
                        x(i,j) = 1;
                        
                        if i>1
                            if tab_fin(i-1,j) == 0
                                tab_fin(i-1,j) = 1;
                            else
                                tab_fin(i-1,j) = 0;
                            end
                        end
                        if i < m
                            if tab_fin(i+1,j) == 0
                                tab_fin(i+1,j) = 1;
                            else
                                tab_fin(i+1,j) = 0;
                            end
                        end
                        if j>1
                            if tab_fin(i,j-1) == 0
                                tab_fin(i,j-1) = 1;
                            else
                                tab_fin(i,j-1) = 0;
                            end
                        end
                        if j<n
                            if tab_fin(i,j+1) == 0
                                tab_fin(i,j+1) = 1;
                            else
                                tab_fin(i,j+1) = 0;
                            end
                        end
%                     else


                    end
                end
            end
        end
    


%         end
        % Restricao que a soma dos elementos da matriz tab_fin tem que ser
        % a soma m+n
        sum(tab_fin(:)) == m*n;
cvx_end

% Exibir a solução
X = x;
disp('Matriz de seleções:')
disp(X)

tabuleiro_final = tab_fin;
disp('Tabuleiro Final:')
disp(tabuleiro_final)

%% Problema do SUDOKU

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

    % Objetivo (apenas para ajudar o solver a convergir mais rápido, pode ser zero)
    minimize(0)
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
