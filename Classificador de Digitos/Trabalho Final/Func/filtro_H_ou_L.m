function retorno = filtro_H_ou_L(escolha,corte)
    %vai esolher um high ou um low pass
    %e tambem passa uma freq de corte
    
    [x,y] = meshgrid(-14:13, -14:13);
    z=sqrt(x.^2+y.^2);
    
    if escolha == 1
        % high
        c = z>corte;
    else
        % low
        c = z<corte;
    end
    
    retorno = c;
end