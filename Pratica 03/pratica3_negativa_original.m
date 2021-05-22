% Negativa e recupera imagem original a partir da negativa - mostra as Três Imagens
img = imread("pout.tif");
img_ng = negative_img(img);
img_rollback = rollback_negative_img(img_ng);

img = imread("pout.tif");
subplot(2,2,1);
title (sprintf ("Imagem Original"));
hold on;
imshow(img);
hold off;
subplot(2,2,2);
title (sprintf ("Imagem Negativa"));
hold on;
imshow(negative_img(img));
hold off;
subplot(2,2,3);
title (sprintf ("Imagem Original a partir da Negativa"));
hold on;
imshow(rollback_negative_img(negative_img(img)));
hold off;

function g = negative_img(img)
    g = 255 - 1 - img;
end

function f = rollback_negative_img(g)
    f = 255 - 1 - g ;
end

%{ 
Questão 3:

De acordo com a imagem gerada a partir da operação de negativação, podemos
observar um realce maior nas partes mais claras da imagem original,
observando mais claramente os detalhes do casaco da menina, alem da
vegetação atrás da cerca que está no fundo da imagem. Outro fator
interessante, é o destaque para os resíduos no cabelo.
%}


