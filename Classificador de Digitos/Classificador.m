%limpar variaveis
clear; 
%limpar tela
clc; 
%fechar telas
close all; 

%carrega a base
data = load('mnist_test.csv');

%todas as linhas da primeira coluna
labels = data(:,1);

% resto sao as imagens
images = data(:, 2:785);

colormap gray
% faz a imagem 
imagesc(reshape(images(1,:), 28, 28)')

% filtro
filtro = [0.0625 0.125 0.0625; 0.125 0.25 0.125;0.0625 0.125 0.0625];


imagem = (reshape(images(1,:), 28, 28)');
% convolucao da imagem 1 com o filtro
C = convH(imagem, filtro);

C_teste = (reshape(C(:,:), 1, 28)');
% se comporta com o 'valid' - 26x26

% exibindo a imagem toda doida
figure;
colormap gray
imagesc(C)
% se tiver usado um filtro que deixa valores negativos
% fica num tom de cinza diferente


% % passando por essa funcao de ativacao 
% % pra tirar os negativos
% C_2 =  max (0,C);
% 
% % exibindo imagem final estranha
% figure;
% colormap gray
% imagesc(C_2)
