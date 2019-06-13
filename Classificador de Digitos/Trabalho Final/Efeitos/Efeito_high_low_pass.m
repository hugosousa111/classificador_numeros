close all;clear;clc;

%% carregando cameraman
imagem2 = imread('cameraman.tif');
figure;
imshow(imagem2); 
title('Original Cameraman');

%% transformada
tf_imagem2 = fftshift(fft2(imagem2));

%% exibir imagem filtrada na freq
figure;
imshow(real(log(1+abs(tf_imagem2))),[])

%% criando uma malha pra fazer um filtro
[x,y] = meshgrid(-128:127, -128:127);
z=sqrt(x.^2+y.^2);

%% filtro
%corte = z<30; %% lowpass
corte = z>15; %% highpass
figure;
imshow(corte,[])

%% filtrando 
tf_img2_f = tf_imagem2.*corte;
figure;
imshow(real(log(1+abs(tf_img2_f))),[])

%% fazendo a inversa
imagem_f = ifft2(fftshift(tf_img2_f));
figure;
imshow(real(imagem_f),[])