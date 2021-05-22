% Negativa e recupera imagem original a partir da negativa - mostra as Tr�s Imagens
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
Quest�o 3:

De acordo com a imagem gerada a partir da opera��o de negativa��o, podemos
observar um realce maior nas partes mais claras da imagem original,
observando mais claramente os detalhes do casaco da menina, alem da
vegeta��o atr�s da cerca que est� no fundo da imagem. Outro fator
interessante, � o destaque para os res�duos no cabelo.
%}


