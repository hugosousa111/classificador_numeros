function retorno = fftH_g(imagens)
    % pega a base e chama varias vezes a funcao de fourier pra cada imagem
    
    % pegando o tamanho da matriz imagem
    [l,c] = size(imagens);
    
    % matriz que vai guardar as imagens depois da fourier
    % pre-alocando
    imagens_F = zeros(l,784);
    
    for a = 1:l
        % organizo no formado 28x28 como uma imagem
        imagem = reshape(imagens(a,:), 28, 28)'; 
        
        % faz a transformada
        % aux = fftH(imagem);
        aux = fft2(imagem);
        
        % a funcao que eu implementei ffth funciona,
        % mas o tempo de processamento dela eh muito 
        % maior do que a funcao ja pronta do matlab, a fft2
        % para rodar mais rapido eu deixei a fft2,
        % em alguns teste eu calculei que a ffth ia demorar
        % algumas horas, enquanto a fft2 pega alguns minutos
        
        % reorganizo do formado 28x28 para 1x784
        % e guardo dentro da variavel que vai retornar
        imagens_F(a,:) = (reshape(aux(:,:)', 784, 1)');
        %disp(a)
    end
    
    retorno = imagens_F;
end
