%% limpar variaveis, limpar console, fechar telas
clear; clc; close all; 

%% semente do rand
% para analisar os resultados com a mesma semente
rng(1); 

%% funcoes
addpath('Func/');
% funcoes de convolucao estao nessa pasta

%% carrega a base
% demora um pouco nessa parte devido o tamanho da base
% totol de 70000 amostras
data_train= load('Imagens\mnist_train.csv');
data_test = load('Imagens\mnist_test.csv');

% junto a base, porque ela ja veio separada e 
% eu quero permutar essas imagens
data = [data_train; data_test];

%% permutar a base 
rand_pos = randperm(length(data(:,1)));

data_randomico = zeros(length(data(:,1)),length(data(1,:)));

% novo matriz reorganizada
for k = 1:length(data(:,1))
    data_randomico(k,:) = data(rand_pos(k),:);
end
%permutei as imagens na base

%% roda 5 vezes
% a base tem esse formato
% base = [parte1, parte2, parte3, parte4, parte5]
% 1 iteracao: teste com parte 1, treino com o resto
% 2 iteracao: teste com parte 2, treino com o resto
% 3 iteracao: teste com parte 3, treino com o resto
% 4 iteracao: teste com parte 4, treino com o resto
% 5 iteracao: teste com parte 5, treino com o resto

a = 14000; % auxilia na parte de separar a base

% vetor que vai armazenar as acuracias
acuracia = zeros(1,5);

for i=1:5 % roda 5 vezes
    disp(i) % so pra saber em qual iteracao esta
    
    %% separar 20% da base pra teste e 80% pra treino

    data_test = data((a-13999):a,:);

    if a == 14000
        data_train = data(14001:70000,:);
    elseif a == 70000
        data_train = data(1:56001,:);
    else
        data_train = data([1:(a-14000),(a+1):70000],:);
    end

    %% todas as linhas da primeira coluna sao as classes
    labels_train = data_train(:,1);
    labels_test = data_test(:,1);

    % resto das linhas sao as imagens
    images_train = data_train(:, 2:785);
    images_test = data_test(:, 2:785);

    %% exibindo uma das imagens
    %figure;
    %colormap gray;
    % % faz a imagem 
    %imagesc(reshape(images_train(50,:), 28, 28)')

    %% filtro escolhido 
    % para escolher o filtro
    % deve-se comentar as outras linhas e
    % desconmentar a linha do filtro desejado
  
    filtro = fspecial('average',3);
    %filtro = fspecial('disk',1);
    %filtro = fspecial('prewitt');
    
    %% chamando a funcao convolucao 
    % nessa parte cada imagem da base 
    % eh convoluida com o filtro
    images_C_train = convH_g(images_train, filtro);
    images_C_test = convH_g(images_test, filtro);
    
    %% sem filtro
    % para o caso sem filtro, 
    % deve-se comentar a parte acima, da convolução
    % e descomentar as linhas a seguir
  
    %images_C_train = images_train;
    %images_C_test = images_test;
    
    %% exibindo uma imagem especifica convoluida
    %figure;
    %colormap gray;
    %imagesc(reshape(images_C_train(50,:), 26, 26)')
    
    %% atributos
    q = 40; % numero de atributos
    Mdl2 = sparsefilt(abs(images_C_train),q,'IterationLimit',10);
    % essa funcao retorna um modelo de atributos 
    % das imagens da minha base
    
    % base com os atributos das imagens de treino
    New_train = transform(Mdl2,abs(images_C_train));
    
    % base com os atributos das imagens de teste 
    New_test = transform(Mdl2,abs(images_C_test));


    %% treino
    % para escolher um metodo de classificacao 
    % deve-se descomentar o metodo desejado 
    
    % treinando usando KNN
    Mdl = fitcknn(New_train,labels_train,'NumNeighbors',5,'Standardize',1); 
    
    % treinando usando Naive Bayes
    %Mdl = fitcnb(New_train,labels_train);
    
    % treinando usando Decision Tree
    %Mdl = fitctree(New_train,labels_train); 
    
    %% teste
    % faz as previsoes com a base de teste
    y_pre = predict(Mdl,New_test);
    
    % calcula o numero de acertos e divide pelo tamanho
    % para obter a acuracia
    acuracia(i) = sum(y_pre == labels_test) / length(labels_test) *100;

    disp(i) % so pra saber em qual iteracao esta
end

%% infomacoes
% media das acuracias 
md_acuracia = sum(acuracia)/5
% desvio padrao das acuracias 
dp_acuracia = std(acuracia)
