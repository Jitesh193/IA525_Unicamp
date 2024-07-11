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

% x = zeros(m,n);

% Inicializar o CVX
cvx_begin
    cvx_solver mosek  % Usar o solver MOSEK
    variable inver integer  % numero de inversoes

    % Função objetivo: minimizar o número de inversões
    minimize( inver ) 
    
    % Restrições
    subject to
%         while sum(tab_fin(:)) <= 20
            % Construcao das restricoes de inversoes de casas
            for i=1:m
                for j=1:n
                    if i == 1

                        if M1(1,1) == 0
                            x(i,j) == 1;
                            M1(i,j) = 1;

                            if M1(i+1,j) == 0
                                M1(i+1,j) = 1;
                            else
                                M1(i+1,j) = 0;
                            end

                        elseif j>1 && M1(i,j) == 0
                            if M1(i,j-1) == 0 
                                x(i,j) == 1

                                if M1(i+1,j) == 1
                                    M1(i+1,j) = 0;
                                else
                                    M1(i+1,j) = 1;
                                end
                                
                                if j<n
                                    if M1(i,j-1) == 1
                                        M1(i,j-1) = 0;
                                    else
                                        M1(i,j-1) = 1;
                                    end
                                    if M1(i,j+1) == 1
                                        M1(i,j+1) = 0;
                                    else
                                        M1(i,j+1) = 1;
                                    end
%                                 elseif j == n
%                                     if tab_fin(i,j-1)
                                end
                            end
                        end
                    end
                    if M1(i,j) == 0
                        if M1(1,1) == 0|| M1(i,j-1) == 0 || M1(i-1,j) == 0
                            x(i,j) == 1;

                            if i>1
                                if M1(i-1,j) == 1
                                    M1(i-1,j) = 0;
                                else
                                    M1(i-1,j) =1;
                                end
                            end
                            if i<m
                                if M1(i+1,j) == 1
                                    M1(i+1,j) = 0;
                                else
                                    M1(i+1,j) =1;
                                end
                            end
                            if j>1
                                if M1(i,j-1) == 1
                                    M1(i,j-1) = 0;
                                else
                                    M1(i,j-1) =1;
                                end
                            end
                            if j<n
                                if M1(i,j+1) == 1
                                    M1(i,j+1) = 0;
                                else
                                    M1(i,j+1) =1;
                                end
                            end
                            end
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
