% Negativa e Mostra as Duas Imagens
img = imread("pout.tif");
subplot(1,2,1);
title (sprintf ("Imagem Original"));
hold on;
imshow(img);
hold off;
subplot(1,2,2);
title (sprintf ("Imagem Negativa"));
hold on;
imshow(negative_img(img));
hold off;

function g = negative_img(img)
    g = 255 - 1 - img;
end
