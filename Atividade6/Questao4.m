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
cap_max = [10 ; 10 ; 15 ; 10 ; 10];
% cap_max = [1 ; 3 ; 18 ; 1 ; 2];
% cap_max = [1 ; 2 ; 3 ; 1 ; 2];
fonte = 1;
dreno = 4;

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
% Fazendo o método de aplicar 2 problemas de fluxo máximo, o primeiro
% obteve-se um fluxo de f=17
% Dados das reuniões
% Dados das reuniões
inicio = [13, 18, 10, 16, 16, 13, 14, 11];
termino = [13.5, 20, 11, 17.5, 19, 15, 17, 12];
preparacao_par = 1; % 1 hora para reuniões pares
preparacao_impar = 0.5; % 30 minutos para reuniões ímpares
n = length(inicio);

% Adicionando nós de origem e destino
s = 1; % origem
t = 2; % destino
u = 3:3+n-1; % nós de início de reuniões
v = 3+n:3+2*n-1; % nós de término de reuniões

% Construção da matriz de adjacência considerando os tempos de preparação
A = zeros(2 + 2*n);

% Conectar origem aos nós de início de reuniões
for i = 1:n
    A(s, u(i)) = 1;
end

% Conectar nós de término de reuniões ao destino
for i = 1:n
    A(v(i), t) = 1;
end

% Conectar nós de início aos nós de término das mesmas reuniões
for i = 1:n
    A(u(i), v(i)) = 1;
end

% Conectar nós de término de reuniões a nós de início de outras reuniões
for i = 1:n
    for j = 1:n
        if i ~= j
            if mod(i, 2) == 0
                preparacao = preparacao_par;
            else
                preparacao = preparacao_impar;
            end
            if termino(i) + preparacao <= inicio(j)
                A(v(i), u(j)) = 1;
            end
        end
    end
end

cvx_begin
cvx_solver mosek
    variable x(2 + 2*n, 2 + 2*n) integer % variáveis de fluxo e número mínimo de salas
    variable f integer
    % Função objetivo
    minimize(f)

    % Restrições
    subject to
        % Fluxo de origem ao destino deve ser igual a f
        sum(x(s, :)) - sum(x(:, s)) == f;
        sum(x(:, t)) - sum(x(t, :)) == f;

        % Restrições de fluxo nos nós intermediários
        for i = 1:n
            sum(x(u(i), :)) - sum(x(:, u(i))) == 0;
            sum(x(v(i), :)) - sum(x(:, v(i))) == 0;
        end

        % Restrições de capacidade
        for i = 1:2+2*n
            for j = 1:2+2*n
                if A(i, j) == 0
                    x(i, j) == 0;
                end
            end
        end

        % Limite inferior e superior para fluxo
        0 <= x <= 1;
cvx_end
