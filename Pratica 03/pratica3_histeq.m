I = imread('pout.tif');
% Imagem original

subplot(3,2,1)
imshow(I)
title (sprintf ("Imagem Original"));
subplot(3,2,2)
imhist(I,64)
title (sprintf ("Histograma"));

J = histeq(I);
% Imagem equalizada

subplot(3,2,3)
imshow(J)
title (sprintf ("Imagem Equalizada"));
subplot(3,2,4)
imhist(J,64)
title (sprintf ("Histograma"));

% Plot da curva de equalização
[J,T] = histeq(I);
subplot(3,2,5)
plot((0:255)/255,T);
title (sprintf ("Curva de Equalização"));