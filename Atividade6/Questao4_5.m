clc;
clear;

%%
% Questao 4 - algoritmo para resolucao do problema de fluxo minimo

% Construcao da matriz de incidencia para o exemplo citado
A = [1 1 0 0 0 ; 
    -1 0 1 1 0 ; 
    0 -1 -1 0 1 ; 
    0 0 0 -1 -1 ];

nos = size(A,1);        % numero de nos
arestas = size(A,2);    % numero de arestas

% Capacidades minimas e maximas de cada aresta
cap_min = [2 ; 1 ; 3 ; 1 ; 2];
cap_max = [10 ; 10 ; 15 ; 11 ; 9];

% Indicacao dos nos que sao a fonte e dreno
fonte = 1;
dreno = 4;

% Inicio do CVX
cvx_begin
    cvx_solver mosek
    variable x(arestas) integer
    variable f integer
    minimize(f)
    subject to
        % Restrições de fluxo de conservação para todos os nós
        for i = 1:nos
            if i == fonte
                sum(x(A(i,:) == 1)) - sum(x(A(i,:) == -1)) == f;
            elseif i == dreno
                sum(x(A(i,:) == 1)) - sum(x(A(i,:) == -1)) == -f;
            else
                sum(x(A(i,:) == 1)) - sum(x(A(i,:) == -1)) == 0;
            end
        end
        % Restrições de capacidade
        cap_min <= x <= cap_max;
cvx_end

% Exibir o resultado
disp('O fluxo mínimo é:')
disp(cvx_optval)
disp('Os valores de x são:')
disp(x)

%%
% Questão 5 - alocacao de salas para reunioes

% Indicacao das arestas da rede
edges = [
    1 2;
    1 4;
    1 6;
    1 8;
    1 10;
    1 12;
    1 14;
    1 16;
    2 3;
    4 5;
    6 7;
    10 11;
    14 15;
    16 17;
    8 9;
    12 13;
    3 18;
    5 18;
    7 18;
    9 18;
    11 18;
    13 18;
    15 18;
    17 18;
    3 6;
    3 10;
    3 14;
    3 16;
    3 8;
    3 12;
    7 10;
    7 16;
    7 12;
    11 8;
    15 10;
    15 8;
    15 12;
    17 8;
    5 6;
    5 10;
    5 16;
    5 12;
    5 8
        ];

nos2 = 18;      % Numero de nos

% Construcao da matriz de incidencia
A2 = incidenceMatrix(nos2, edges);

arestas2 = size(A2,2);  % Numero de arestas

% Capacidades minimas e maximas de cada aresta
cap_min2 = [0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ];
cap_max2 = [1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 2 ; 3 ; 2 ; 3 ; 4 ; 3 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ];

% Indicacao dos nos que sao a fonte e dreno
fonte = 1;
dreno = 18;

% Inicio do mesmo algoritmo CVX utilizado na secao anterior
cvx_begin
    cvx_solver mosek
    variable x(arestas2) integer
    variable f integer
    minimize(f)
    subject to
        % Restrições de fluxo de conservação para todos os nós
        for i = 1:nos2
            if i == fonte
                sum(x(A2(i,:) == 1)) - sum(x(A2(i,:) == -1)) == f;
            elseif i == dreno
                sum(x(A2(i,:) == 1)) - sum(x(A2(i,:) == -1)) == -f;
            else
                sum(x(A2(i,:) == 1)) - sum(x(A2(i,:) == -1)) == 0;
            end
        end
        % Restrições de capacidade
        cap_min2 <= x <= cap_max2;
cvx_end

% Exibir o resultado
disp('O fluxo mínimo é:')
disp(cvx_optval)
disp('Os valores de x são:')
disp(x)

% Funcao para a geracao da matriz de incidencia baseada nas arestas da rede
function A = incidenceMatrix(n, edges)
    % n: número de nós
    % edges: matriz mx2 onde cada linha representa uma aresta e cada coluna
    %        a origem (coluna 1) e o destino (coluna 2) de cada aresta
    % A: matriz de incidência

    m = size(edges, 1); % número de arestas
    A = zeros(n, m); % inicializa a matriz de incidência com zeros

    for i = 1:m
        origem = edges(i, 1);
        destino = edges(i, 2);
        A(origem, i) = 1; % nó de origem
        A(destino, i) = -1; % nó de destino
    end
end