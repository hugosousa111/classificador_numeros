%% limpar variaveis, limpar console, fechar telas
clear; clc; close all;


%% funcoes
addpath('..\Func');

%% carregando cameraman
imagem2 = imread('cameraman.tif');
figure;
imshow(imagem2); 
title('Original Cameraman');

%% filtro gaussiano
filtro = fspecial('gaussian',256,30);
% sigma eh onde corta
figure;
imshow(filtro,[])
title('Filtro Gaussian')
%max(g(:)); % da 0.0016
% por isso escala de 1 a 0

%% escalonando
filtro_e = mat2gray(filtro);

%% transformada
tf_imagem2 = fftshift(fft2(imagem2));


%% exibir imagem na freq
figure;
imshow(real(log(1+abs(tf_imagem2))),[])
title('log ft')

%% aplicando o filtro
tf_img2_filtro = tf_imagem2.*filtro_e;

%% aplico o log
log_tf_img2_f = log(1+abs(tf_img2_filtro));

%% exibir imagem filtrada na freq
figure;
imshow(real(log_tf_img2_f),[])
title('fft filtrada')

%% fazendo a inversa
imagem_f = ifft2(fftshift(tf_img2_filtro));
figure;
imshow(real(imagem_f),[])
title('Imagem Filtrada')

