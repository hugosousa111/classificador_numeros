function retorno = ifftH_g(imagens)
    % pega a base e chama varias vezes a funcao de fourier pra cada imagem
    
    % pegando o tamanho da matriz imagem
    [l,c] = size(imagens);
    
    % matriz que vai guardar as imagens depois da fourier
    % pre-alocando
    imagens_F = zeros(l,784);
    
    for a = 1:l
        % organizo no formado 26x26 como uma imagem
        imagem = reshape(imagens(a,:), 28, 28)'; 
        
        % faz a transformada
        % aux = fftH(imagem);
        aux = ifft2(imagem);
        
        % reorganizo do formado 26x26 para 1x676
        % e guardo dentro da variavel que vai retornar
        imagens_F(a,:) = (reshape(aux(:,:)', 784, 1)');
        %disp(a)
    end
    
    retorno = imagens_F;
end
