% limpar variaveis, limpar console, fechar telas
clear; clc; close all; 

% carrega a base
data = load('mnist_test.csv');

% todas as linhas da primeira coluna sao as classes
labels = data(:,1);

% resto das linhas sao as imagens
images = data(:, 2:785);

% exibindo uma das imagens
% colormap gray
% % faz a imagem 
% imagesc(reshape(images(50,:), 28, 28)')

% filtro escolhido 
% blur
filtro = [0.0625 0.125 0.0625; 0.125 0.25 0.125;0.0625 0.125 0.0625];

% images_C eh matriz que vai guardar as imagens convoluidas

% chamando a funcao convolucao 
images_C = convH_g(images(1:500,:), filtro);

% exibindo uma imagem especifica convoluida
% figure;
% colormap gray;
% imagesc(reshape(images_C(50,:), 26, 26)')

% teste
% imagem1 = (reshape(images(50,:), 28, 28)');
% teste = convH(imagem1, filtro);
% 
% figure;
% colormap gray
% imagesc(teste)


% fazendo a transformada de fourier 
imagens_C_F = fftshift(fftH_g(images_C));

% % exibindo uma imagem especifica transformada
% figure;
% colormap gray;
% imagesc(abs(reshape(images_C_F(50,:), 26, 26)'))

% figure;
% colormap gray;
% imagesc(abs(fftH(reshape(images_C(50,:), 26, 26)')));
%F = fftH(reshape(images_C(2,:), 26, 26)');

%%%%FALTA O FFSHIT

% extraindo as caracteristicas
atrib_imgs = ex_atribH_g(imagens_C_F);


CONSTANTE_SVM = 1;
KERNEL = 'polynomial';

Md1 = fitcsvm(abs(atrib_imgs(1:400,:)), labels(1:400,1), ...
            'KernelFunction', KERNEL,'PolynomialOrder', 2, 'BoxConstraint', CONSTANTE_SVM,...
            'Standardize', true, 'ClassNames', {int2str(0), int2str(9)});




acuracia = sum(str2num(cell2mat(predict(Md1,abs(atrib_imgs(401:500,:))))) == labels(401:500,1))/length(labels(401:500,1))*100;

%== labels(81:100,1)
%
% imagem = (reshape(images(18,:), 28, 28)');
% % convolucao da imagem 1 com o filtro
% C = convH(imagem, filtro);
% 
% C_linha = (reshape(C(:,:)', 676, 1)');
% % se comporta com o 'valid' - 26x26
% 
% %extracao de caracteristicas
% 
% 
% 
% 
% % exibindo a imagem toda doida
% figure;
% colormap gray
% imagesc(C)
% % se tiver usado um filtro que deixa valores negativos
% % fica num tom de cinza diferente
% 
% 
% % % passando por essa funcao de ativacao 
% % % pra tirar os negativos
% % C_2 =  max (0,C);
% % 
% % % exibindo imagem final estranha
% % figure;
% % colormap gray
% % imagesc(C_2)
