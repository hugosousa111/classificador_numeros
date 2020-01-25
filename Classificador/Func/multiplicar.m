function retorno = multiplicar(imgs,filtro)
    % vai pegar uma matriz com varias imagens no dominio da freq
    % que estao nas linhas, e multiplicar por um filtro
    
    % pegando o tamanho da matriz imagem
    [l,c] = size(imgs);
    
    imgs_F = zeros(l,784);
    
    for a = 1:l
        % organizo no formado 28x28 como uma imagem
        imagem = reshape(imgs(a,:), 28, 28)'; 
        
        % filtro a imagem
        aux = imagem*filtro;
        
        % reorganizo do formado 28x28 para 1x784
        % e guardo dentro da variavel que vai retornar
        imgs_F(a,:) = (reshape(aux(:,:)', 784, 1)');
        
    end
    
    retorno = imgs_F;
end