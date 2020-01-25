function retorno = filtro_H_ou_L(escolha,corte)
    %vai escolher um high ou um low pass
    %e tambem recebe uma freq de corte
    
    [x,y] = meshgrid(-14:13, -14:13); 
    % do tamanho da imagem, que eh 28x28
    z=sqrt(x.^2+y.^2);
    % o circulo central
    
    if escolha == 1
        % high
        c = z>corte;
        % pega so a parte de fora 
    else
        % low
        c = z<corte;
        % pega so a parte de dentro 
    end
    
    retorno = c;
end