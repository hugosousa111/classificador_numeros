%% limpar variaveis, limpar console, fechar telas
clear; clc; close all; 

%% semente do rand
% para analisar os resultados com a mesma semente
rng(1); 

%% funcoes
addpath('Func/');
% funcoes de fft estao nessa pasta

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
    
    %% transformacao das imagens
    % essa parte usa a funcao para fazer as transformadas
    images_F_train = fftH_g(images_train);
    images_F_test = fftH_g(images_test);
    
    %% filtro escolhido 
    % para escolher o filtro
    % deve-se comentar as outras linhas e
    % desconmentar a linha do filtro desejado
    
    filtro_corte = filtro_H_ou_L(1,15); % high
    %filtro_corte = filtro_H_ou_L(2,16); % low

    % os valores de corte 15 e 16 foram escolhidos 
    % depois de testes com varios valores, 
    % e esses foram os que tiveram melhor resultados
    
    %% aplicando o filtro em todas as imagens 
    % pra aplicar o filtro eh so multiplicar 
    % cada imagem com o filtro
    images_F_fil_train = multiplicar(images_F_train,filtro_corte);
    images_F_fil_test = multiplicar(images_F_test,filtro_corte);
    
    %% sem filtro
    % para o caso sem filtro, 
    % deve-se comentar a parte acima, da multiplicacao
    % e descomentar as linhas a seguir
    
    %images_F_fil_train = images_F_train;
    %images_F_fil_test = images_F_test;
    
    %% features
    q = 40; % numero de atributos
    Mdl2 = sparsefilt(real(images_F_fil_train),q,'IterationLimit',10);
    % essa funcao retorna um modelo de atributos 
    % das imagens da minha base
    
    % base com os atributos das imagens de treino
    New_train = transform(Mdl2,real(images_F_fil_train));

    % base com os atributos das imagens de teste
    New_test = transform(Mdl2,real(images_F_fil_test));

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