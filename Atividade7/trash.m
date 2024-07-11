subject to
%         while sum(tab_fin(:)) <= 20
            % Construcao das restricoes de inversoes de casas
            for i=1:m
                for j=1:n
                    if i == 1

                        if tab_fin(1,1) == 0
                            x(i,j) == 1;
                            tab_fin(i,j) = 1;

                            if tab_fin(i+1,j) == 0
                                tab_fin(i+1,j) = 1;
                            else
                                tab_fin(i+1,j) = 0;
                            end

                        elseif j>1 && tab_fin(i,j) == 0
                            if tab_fin(i,j-1) == 0 
                                x(i,j) == 1

                                if tab_fin(i+1,j) == 1
                                    tab_fin(i+1,j) = 0;
                                else
                                    tab_fin(i+1,j) = 1;
                                end
                                
                                if j<n
                                    if tab_fin(i,j-1) == 1
                                        tab_fin(i,j-1) = 0;
                                    else
                                        tab_fin(i,j-1) = 1;
                                    end
                                    if tab_fin(i,j+1) == 1
                                        tab_fin(i,j+1) = 0;
                                    else
                                        tab_fin(i,j+1) = 1;
                                    end
                                elseif j == n
                                    if tab_fin(i,j-1)
                            end
                        end
                    if tab_fin(i,j) == 0
                        if tab_fin(1,1) == 0|| tab_fin(i,j-1) == 0 || tab_fin(i-1,j) == 0
                            x(i,j) == 1;

                            if i>1
                                if tab_fin(i-1,j) == 1
                                    tab_fin(i-1,j) = 0;
                                else
                                    tab_fin(i-1,j) =1;
                                end
                            end
                            if i<m
                                if tab_fin(i+1,j) == 1
                                    tab_fin(i+1,j) = 0;
                                else
                                    tab_fin(i+1,j) =1;
                                end
                            end
                            if j>1
                                if tab_fin(i,j-1) == 1
                                    tab_fin(i,j-1) = 0;
                                else
                                    tab_fin(i,j-1) =1;
                                end
                            end
                            if j<n
                                if tab_fin(i,j+1) == 1
                                    tab_fin(i,j+1) = 0;
                                else
                                    tab_fin(i,j+1) =1;
                                end
                            end
                        end
                    end
                end
                        end

 %% Tentativa 2
 for i=1:m

            if sum(tab_fin(i,:)) < 9
                
                for j=1:n
                    
                    if (i==1 || i==m) && j>=2 && tab_fin(i,j-1) == 0 && tab_fin(i,j) == 0
                        inver ==  inver + 1
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
                    elseif i>1 && j>=2 && tab_fin(i+1,j) == 0 && tab_fin(i,j) == 0
                        inver ==  inver + 1
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
                        inver ==  inver + 1
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

 %% Questao 3

 % Dica 1 - 7,9,3 e 1 digito correto na posicao certa
        d1 = dicas(1,:);
        x(d1(1),1) == 1;
        x(d1(2),2) == 1;
        x(d1(3),3) == 1;
        
        % Dica 2 - 7,2,5 e 1 digito correto na posicao errada
        d2 = dicas(2,:);
        if sum(ismember(d2,d1)) >= 1
            d21 = ismember(d2,d1);
            x(d21(1),:) == 0;
        end
        x(d2(2),2) == 1;
        x(d2(3),3) == 1;

%         % Dica 3 - 3,1,7 e 2 digitos corretos nas posicoes erradas
%         d3 = dicas(3,:);