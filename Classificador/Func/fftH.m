function retorno = fftH(imagem)
    % funcao que faz a transformada de fourier de uma imagem
    % similar ao fft2()

    % essa funcao foi implementada 
    % analisando a formula da tf2d
    % na parte do More About, no seguinte link
    % https://www.mathworks.com/help/matlab/ref/fft2.html
    
    % codigo em latex da formula da tf 2D que foi usada na implementacao: 
    % {Y_{p+1,q+1}}= \sum_{j=0}^{m-1}\sum_{k=0}^{n-1} w_{m}^{jp}w_{n}^{kq}{X_{j+1,k+1}}
    % w_{m} = e^{-2\pi i/m}
    % w_{n} = e^{-2\pi i/n}
    
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