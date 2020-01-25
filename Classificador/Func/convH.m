function retorno = convH(imagem, filtro)
    % funcao que faz a convolucao de uma imagem com um filtro
    % similar ao conv2(,'valid')
    
    % essa funcao foi implementada analisando a convolucao 
    % das matriz que foram explicadas nesse video: 
    % https://www.youtube.com/watch?v=ZOXOwYUVCqw 
    % do minuto 3:10 ate 5:05
        
    % codigo em latex da formula da conv 2D que foi usada na implementacao: 
    % C(j,k)= \sum_{p}^{ }\sum_{q}^{ } A(p,q)B(j-p+1,k-q+1)    

    [l_f,c_f] = size(filtro);
    [l_i,c_i] = size(imagem);

    imagem_conv = zeros(l_i-l_f+1, c_i-c_f+1); %igual ao valid da funcao conv2 do matlab
    % pre estabelece o tamanho da imagem convoluida, 
    % esses valores foram de acordo com os teste
    % imagem(4x4) * filtro(2x2) -> conv(3x3)
    % imagem(28x28) * filtro(3x3) -> conv(26x26)

    for a = 1:l_i-l_f+1
        for b = 1:c_i-c_f+1
            acumulador = 0;
            for j = 1:l_f
                % percorre todas as linhas do filtro
                for k = 1:c_f
                    % percorre todas as colunas do filtro
                    acumulador = acumulador + imagem(j+a-1,k+b-1)*filtro(j,k);
                    % imagem(j+a-1,k+b-1) vai pulando na imagem cada imagezinha do
                    % tamanho do filtro para convoluir
                end
            end
            %guarda o valor na posicao correta
            imagem_conv(a,b) = acumulador;
        end
    end

    retorno = imagem_conv;
end