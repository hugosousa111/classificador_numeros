%% limpar variaveis, limpar console, fechar telas
clear; clc; close all;

%% carregando imagem
imagem = imread('lenna.jpg');
figure;
imshow(imagem); 
title('Original Lenna');

%% cinza
imagem_cinza = rgb2gray(imagem);
figure;
imshow(imagem_cinza); 
title('Cinza Lenna');

%% filtro escolhido 
h_filtro1 = fspecial('average',3);

%% chamando a funcao convolucao 
imagem_conv_1 = convH(imagem_cinza, h_filtro1);

%% exibindo imagem convoluida
figure;
imshow(uint8(imagem_conv_1)); 
title('Filtro Average');

