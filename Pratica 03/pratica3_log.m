% Aplica transformação logarítmica
img = imread("pout.tif");
img_log = log_transform(img);
img = imread("pout.tif");

subplot(2,2,1);
title (sprintf ("Imagem Original"));
hold on;
imshow(img);
hold off;
subplot(2,2,2);
title (sprintf ("Imagem com Logaritmo"));
hold on;
imshow(img_log);
hold off;

function S = log_transform(img)
    c = 255 / (log (double(1 + max(img,[],'all'))));
    S = uint8(c * log (double(1 + img)));
end
