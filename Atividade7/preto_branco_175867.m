clc;
clear;

%% Questao do tabuleiro - Programa Incompleto -> a solucão dá como infactível
% Carregar a matriz M que representa o tabuleiro
M = [1 0 1 1 1
     1 0 1 0 1;
     0 0 1 0 0;
     1 0 0 1 1;
     0 1 0 1 0;
     1 1 0 1 0];

[m, n] = size(M);

% Construcao da matriz do tabuleiro que será modificada
M1 = M;

% Inicializar o CVX
cvx_begin
    cvx_solver mosek  % Usar o solver MOSEK
    variable x(m,n) binary  % matriz de inversoes
%     variable trocas(m,n) integer % Elementos dessa matriz indica quantas trocas foram feitas em cada celula
    variable z(m,n) integer
    % Função objetivo: minimizar o número de inversões
    minimize( sum(sum(x)) ) 
    
    % Restrições
    subject to
        
        for i=1:m
            for j=1:n
                vizinho = [];
                % salva os indices das casas vizinhas
                if i > 1
                    vizinho = [vizinho; i-1, j];
                end
                if i < m
                    vizinho = [vizinho; i+1, j];
                end
                if j > 1
                    vizinho = [vizinho; i, j-1];
                end
                if j < n
                    vizinho = [vizinho; i, j+1];
                end
     
                % Se a casa atual for 0, o numero de trocas dos vizinhos
                % deve ser um numero impar
                if M1(i,j) == 0
                    sum(x(sub2ind([m, n], vizinho(:,1), vizinho(:,2)))) + x(i,j)== 2*z(i,j) + 1
                    M1(i,j) = 1;
                    % inversao das casas vizinhas
                    for k=1:size(vizinho,1)
                        ni = vizinho(k,1);
                        nj = vizinho(k,2);
                        if M1(ni,nj) == 0

                            M1(ni,nj) = 1;
                        else
                            M1(ni,nj) = 0;
                        end
                    end
                % Caso contrario, o numero de inversões deve ser par e o
                % valor da casa deve se manter
                else
                    M1(i,j) = 1;
                    sum(x(sub2ind([m, n], vizinho(:,1), vizinho(:,2)))) + x(i,j) == 2*z(i,j);  % Numero de trocas = num. par
                end
            end    
        end
        % Constraints on z variables
        z(:) >= 0
        z(:) <= 2
        

        
      
cvx_end

% Exibir a solução
X = x;
disp('Matriz de seleções:')
disp(X)
% 
% tabuleiro_final = M1;
% disp('Tabuleiro Final:')
% disp(tabuleiro_final)
