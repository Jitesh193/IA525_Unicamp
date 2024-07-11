clc;
clear;

%%

% Configuração do problema
n = 6; % número de linhas
m = 5; % número de colunas

% Estado inicial do tabuleiro
a = [0 1 1 1 0;
     0 0 0 1 0;
     0 1 1 1 0;
     0 0 0 1 0;
     1 1 1 0 1;
     1 0 0 0 1];

% CVX com Mosek
cvx_begin
    cvx_solver mosek
    variable x(n, m) binary % Variáveis de decisão

    % Variável para estado final do tabuleiro
    variable b(n, m) binary

    % Função objetivo
    minimize( sum(x(:)) )

    % Restrições para que todas as células sejam pretas (b_ij = 1)
    subject to
%     sum_neighbors = 0;
%         b(:,:) == 1;
        for i = 1:n
            for j = 1:m
                
                % Índices vizinhos
                neighbors = [i-1, j; i+1, j; i, j-1; i, j+1];
                % Mantendo dentro dos limites
                neighbors = neighbors(neighbors(:,1) >= 1 & neighbors(:,1) <= n & neighbors(:,2) >= 1 & neighbors(:,2) <= m, :);

                % Soma das inversões nas células vizinhas e na célula atual
                sum_neighbors = x(i,j) + sum(x(sub2ind([n,m], neighbors(:,1), neighbors(:,2))));
                
                % Restrições mod 2 para que todas as células sejam pretas (b_ij = 1)
                b(i,j) == mod(a(i,j) + sum_neighbors, 2);
                b(i,j) == 1;
            end
        end
         
cvx_end

% Exibindo o resultado
disp('Número mínimo de inversões:');
disp(sum(x(:)));
disp('Estado final do tabuleiro:');
disp(mod(a + conv2(x, [0 1 0; 1 1 1; 0 1 0], 'same'), 2));
