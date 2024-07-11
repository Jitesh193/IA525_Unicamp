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
        % Percorre cada linha da matriz de dicas
        for i=1:3
            d = dicas(i,1:3);
            % Isso garante que os elementos da dica serao possibilidades na
            % matriz - agora tem que indicar se está repetido ou não
            for j = 1:length(d)
                linha = d(j);
                coluna = j;
                x(linha,coluna) == 1;
            end




        end

        for i=1:10
            sum(x(i,:)) == 1;
        end
        for i=1:3
            sum(x(:,i)) == 1;
        end
cvx_end


%%

% % Vetor com os elementos
% vetor = [7, 2, 5];
% 
% % Inicializa a matriz de zeros 10x3
% matriz = zeros(10, 3);
% 
% % Atualiza a matriz na posição correspondente
% for i = 1:length(vetor)
%     linha = vetor(i) + 1; % Adiciona 1 porque as linhas representam os números 0-9, então 7 -> 8
%     coluna = i;
%     matriz(linha, coluna) = 1;
% end
% 
% % Exibir a matriz
% disp('Matriz atualizada:');
% disp(matriz);
