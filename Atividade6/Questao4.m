clc;
clear;
% addpath 'C:\Program Files\Mosek\10.2\toolbox\r2017a'
%%
A = [1 1 0 0 0 ; 
    -1 0 1 1 0 ; 
    0 -1 -1 0 1 ; 
    0 0 0 -1 -1 ];

nos = size(A,1);
arestas = size(A,2);

cap_min = [2 ; 1 ; 3 ; 1 ; 2];
% cap_min = [0 ; 0 ; 0 ; 0 ; 0];
cap_max = [10 ; 10 ; 15 ; 11 ; 9];
% cap_max = [10 ; 6 ; 0 ; 8 ; 9];
% cap_max = [1 ; 2 ; 3 ; 1 ; 2];
fonte = 1;
dreno = 4;

cvx_begin
    cvx_solver mosek
    variable x(arestas) integer
    variable f integer
    maximize(f)
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
% Definicao da matriz de incidencia A com os dados fornecidos
n = 18; % número de nós
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
];  % arestas

A2 = incidenceMatrix(n, edges);  % Matriz de incidencia do problema

nos2 = size(A2,1);
arestas2 = size(A2,2);

% Definicao das capacidades minimas e maximas de cada ramo
cap_min2 = [0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ; 0 ];
cap_max2 = [1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 2 ; 2 ; 3 ; 2 ; 6 ; 5 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ; 1 ];

fonte = 1;
dreno = 18;


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
    % edges: matriz mx2 onde cada linha representa uma aresta com o nó de origem e de destino
    % A: matriz de incidência

    m = size(edges, 1); % número de arestas
    A = zeros(n, m); % inicializa a matriz de incidência com zeros

    for i = 1:m
        origin = edges(i, 1);
        destination = edges(i, 2);
        A(origin, i) = 1; % nó de origem
        A(destination, i) = -1; % nó de destino
    end
end