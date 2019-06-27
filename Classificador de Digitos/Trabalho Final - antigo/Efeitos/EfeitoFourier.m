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

%% transformada
tf_imagem2 = fftshift(fft2(double(imagem_cinza)));

l_tf = log(1+abs(tf_imagem2));
figure;
imshow(l_tf,[]);
title('log tf')

%% reconstrucao
tf_imagem2 = ifft2(ifftshift(tf_imagem2));
figure;
imshow(tf_imagem2,[]);
title('reconstrucao')
