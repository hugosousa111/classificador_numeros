function retorno = fftH(imagem)
    [l,c] = size(imagem);
    % numero de linhas e colunas da imagem
    
    % imagem de retorno
    imagem_fourier = zeros(l, c);

    s = 0;
    m = l;
    n = c;
    for p = 0:m-1
        for q = 0:n-1
            acumulador = 0;
            for j = 0:m-1
                for k = 0:n-1
                    % aplicando a funcao de transformada de fourier 2d
                    % e acumulando os valores
                    acumulador = acumulador + (exp((((-2)*pi*1i)/m)*j*(p-m)) * exp((((-2)*pi*1i)/n)*k*(q-n)) * imagem(j+1,k+1));
                    % so pra eu saber q tava funcionando
                    disp(s)
                    s=s+1;
                end
            end
            % pegando o resultado e colocando no pixel certo
            imagem_fourier(p+1,q+1) = acumulador;
        end
    end
    
    retorno = imagem_fourier;
end