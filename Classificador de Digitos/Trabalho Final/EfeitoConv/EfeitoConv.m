%% limpar variaveis, limpar console, fechar telas
clear; clc; close all;

%% funcoes
addpath('..\Func');

%% carregando imagem
imagem = imread('..\Imagens\lenna.jpg');
figure;
imshow(imagem); 
title('Original Lenna');

%% cinza
imagem_cinza = rgb2gray(imagem);
figure;
imshow(imagem_cinza); 
title('Cinza Lenna');


%% filtro average
    %% filtro escolhido
    h_filtro1 = fspecial('average',3);

    %% chamando a funcao convolucao 
    imagem_conv_1 = convH(imagem_cinza, h_filtro1);

    %% exibindo imagem convoluida
    figure;
    imshow(uint8(imagem_conv_1)); 
    title('Filtro Average');

%% filtro gaussian
    %% filtro escolhido
    h_filtro2 = fspecial('gaussian',3);

    %% chamando a funcao convolucao 
    imagem_conv_2 = convH(imagem_cinza, h_filtro2);

    %% exibindo imagem convoluida
    figure;
    imshow(uint8(imagem_conv_2)); 
    title('Filtro Gaussian');

%% filtro sobel
    %% filtro escolhido
    h_filtro3 = fspecial('prewitt');

    %% chamando a funcao convolucao 
    imagem_conv_3 = convH(imagem_cinza, h_filtro3);

    %% exibindo imagem convoluida
    figure;
    imshow(uint8(imagem_conv_3)); 
    title('Filtro prewitt');

%% filtro disk
    %% filtro escolhido
    h_filtro4 = fspecial('disk',1);

    %% chamando a funcao convolucao 
    imagem_conv_4 = convH(imagem_cinza, h_filtro4);

    %% exibindo imagem convoluida
    figure;
    imshow(uint8(imagem_conv_4)); 
    title('Filtro disk');
    
%% carregando imagem
imagem2 = imread('..\Imagens\cameraman.jpg');
imagem2 = rgb2gray(imagem2);
figure;
imshow(imagem2); 
title('Original Cameraman');

%% ruido
imagem2_ruido = imnoise(imagem2,'gaussian',0.01);
figure;
imshow(imagem2_ruido); 
title('Cameraman Ruido');

%% filtro escolhido
filtrado = wiener2(imagem2_ruido, [5 5]);

%% exibindo imagem convoluida
figure;
imshow(uint8(filtrado)); 
title('Filtro Cameraman');