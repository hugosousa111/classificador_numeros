%% limpar variaveis, limpar console, fechar telas
clear; clc; close all; 

rng(1); %semente do rand

%% carrega a base
data = load('mnist_train.csv');
data_test = load('mnist_test.csv');

%% todas as linhas da primeira coluna sao as classes
labels = data(:,1);
labels_test = data_test(:,1);

% resto das linhas sao as imagens
images = data(:, 2:785);
images_test = data_test(:, 2:785);

%% exibindo uma das imagens
% colormap gray
% % faz a imagem 
% imagesc(reshape(images(50,:), 28, 28)')

%% filtro escolhido 
% blur
filtro = [0.0625 0.125 0.0625; 0.125 0.25 0.125;0.0625 0.125 0.0625];


%% chamando a funcao convolucao 
images_C = convH_g(images, filtro);
images_C_test = convH_g(images_test, filtro);

%% exibindo uma imagem especifica convoluida
% figure;
% colormap gray;
% imagesc(reshape(images_C(50,:), 26, 26)')

%% fazendo a transformada de fourier 
%imagens_C_F = fftshift(fftH_g(images_C));
%imagens_C_F_test = fftshift(fftH_g(images_C_test));
imagens_C_F = images_C;
imagens_C_F_test = images_C_test;

%% exibindo uma imagem especifica transformada
% figure;
% colormap gray;
% imagesc(abs(reshape(images_C_F(50,:), 26, 26)'))

%% features
q = 40;
Mdl2 = sparsefilt(abs(imagens_C_F),q,'IterationLimit',10);
NewX = transform(Mdl2,abs(imagens_C_F));

TestX = transform(Mdl2,abs(imagens_C_F_test));

%% normalizacao media 0 e desvio padrao unitario
X_mean = mean(NewX);
X_std= std(NewX);
 
X_normalizado = zeros(60000,20); % criacao da matriz que vai ter media 0 e desvio padrao unitario

X_mean_test = mean(TestX);
X_std_test= std(TestX);
 
X_normalizado_test = zeros(10000,20);

for aux = 1:1:60000
    for col = 1:1:20
        X_normalizado(aux,col) = (NewX(aux,col) - X_mean(col))/(X_std(col));
        % formula para normalizar para os paramentos de media 0 e desvio padrao unitario
    end
end
 
for aux = 1:1:10000
    for col = 1:1:20
        X_normalizado_test(aux,col) = (TestX(aux,col) - X_mean_test(col))/(X_std_test(col));
        % formula para normalizar para os paramentos de media 0 e desvio padrao unitario
    end
end

%% treino
Mdl = fitcknn(NewX,labels,'NumNeighbors',5,'Standardize',1);
%Mdl = fitcknn(X_normalizado,labels,'NumNeighbors',5,'Standardize',1);

%% teste
y_pre = predict(Mdl,TestX);
%y_pre = predict(Mdl,X_normalizado_test);

acuracia = sum(y_pre == labels_test) / length(labels_test) *100;
