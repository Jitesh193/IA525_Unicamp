clc;
clear;

%% Jogo da SENHA

% x = zeros(3,9);

dicas = [
        7, 9, 3, 1, 0; % 1 dígito correto e no lugar correto
        7, 2, 5, 0, 1; % 1 dígito correto mas no lugar errado
        3, 1, 7, 0, 2; % 2 dígitos corretos mas no lugar errado
        8, 4, 9, 0, 0; % Nada está correto
        8, 9, 1, 0, 1  % 1 dígito correto mas no lugar errado
    ];

cvx_begin
cvx_solver mosek


    variable x(10,3) binary % Variaveis de decisao

    subject to
        % Restricoes da matriz x
        for i=1:10
            sum(x(i,:)) <= 1;   % Cada digito aparece no máximo 1 vez na senha
        end
        for i=1:3
            sum(x(:,i)) == 1;   % cada posicao deve ter apenas 1 digito
        end

        % Restricoes baseadas nas dicas dadas no exemplo-base
        for i=1:5
            dica = dicas(i,1:3);
            pos_correto = dicas(i,4);   % Numero de digitos corretos na pos. correta
            pos_errado = dicas(i,5);    % Numero de digitos corretos na pos. errada

            contagem_corr = 0;  % contagem de digitos corretos na pos. correta
            
            for j = 1:3
                if dica(j) > 0
                    cor = dica(j);
                    contagem_corr = contagem_corr + x(cor+1, j);
                end
            end
            contagem_corr == pos_correto;   % Assegura que o modelo siga o numero de digitos corretos na pos. correta
                                            % dado pela dica 

            
            contagem_err = 0;  % contagem de digitos corretos na pos. errada
            for j = 1:3
                if dica(j) > 0
                    err = dica(j);
                    for l = 1:3
                        if l ~= j
                            contagem_err = contagem_err + x(err+1, l);
                        end
                    end
                end
            end
            contagem_err == pos_errado;     % Assegura que o modelo siga o numero de digitos corretos na pos. errado
                                            % dado pela dica 
        end
    

cvx_end

% Extracao da solucao
sol = zeros(1,3);
x = full(x);
% j=1;
for i=1:10
    for j=1:3
        if(x(i,j)==1)
            sol(1,j) = i-1;
        end
    end
end

disp('A senha, baseada nas dicas dadas é:')
disp(sol)
