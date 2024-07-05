clc;
clear;
% addpath 'C:\Program Files\Mosek\10.2\toolbox\r2017a'
%%
A = [1 1 0 0 0 ; -1 0 1 1 0 ; 0 -1 -1 0 1 ; 0 0 0 -1 -1];

nos = size(A,1);
arestas = size(A,2);



% cap_min = [1 ; 2 ; 2 ; 2 ; 1];
cap_max = [1 ; 4 ; 2 ; 3 ; 2];

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
        0 <= x <= cap_max;
cvx_end

% Exibir o resultado
disp('O fluxo minimo é:')
disp(cvx_optval)