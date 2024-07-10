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

x = zeros(m,n);

% Inicializar o CVX
cvx_begin
    cvx_solver mosek  % Usar o solver MOSEK
    variable x(m,n) binary  % numero de inversoes
%     variable M1(m,n) binary
    % Função objetivo: minimizar o número de inversões
    minimize( sum(x(:)) ) 
    
    % Restrições
    subject to
        % Montagem da matriz complementar M1
        
        
        



    
cvx_end

% Exibir a solução
X = x;
disp('Matriz de seleções:')
disp(X)

tabuleiro_final = M1;
disp('Tabuleiro Final:')
disp(tabuleiro_final)
