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
