function tabuleiro(M,X)
    [m,n] = size(M);
    C = colormap([1 1 1; 0 0 0; 0 1 0]);
    image(M+1)
    iv = randperm(m);
    jv = randperm(n);
    for i = iv
        for j = jv
            if X(i,j) > 0.7
                tmp = M(i,j);
                M(i,j) = 2;
                image(M+1)
                M(i,j) = tmp;
                pause(1)
                M(i,j) = 1 - M(i,j);
                if i > 1
                    M(i-1,j) = 1 - M(i-1,j);
                end
                if i < m
                    M(i+1,j) = 1 - M(i+1,j);
                end
                if j > 1
                    M(i,j-1) = 1 - M(i,j-1);
                end
                if j < n
                    M(i,j+1) = 1 - M(i,j+1);
                end
                image(M+1)
                pause(0.5)                  
            end
        end
    end


end