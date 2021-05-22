#{
  Autor: Raphael de Lima Mendes
  Descricao: Script da Pratica 1 - Amostragem    
#}
clear;
# Importar pacote para redimensionar imagem (amostragem)
pkg load image;

# Carregar a imagem como matriz
img = imread('relogio.tif');
info = imfinfo('relogio.tif');

pixels_w = getfield(info,'Width');
pixels_h = getfield(info,'Height');

# Calcular o ppi a partir da resolucao
# Fonte: https://www.calculatorsoup.com/calculators/technology/ppi-calculator.php
function retval = calc_ppi(inches_h, inches_w, pixels_h, pixels_w) 
  diag_inches = hypot(inches_h, inches_w);
  diag_pixels = hypot(pixels_h, pixels_w);
  retval = ceil(diag_pixels/diag_inches);
  return;
endfunction 

inches_h = 2.96;
inches_w = 2.25;
ppi = calc_ppi(inches_h, inches_w, pixels_h, pixels_w);
printf ("Pixels Por Polegada da Imagem Original %d.",
        ppi);

# Reducao para 300ppi
# Calcular o fator de reducao
reduction_factor = 300/ppi;
img_300ppi = imresize(img, reduction_factor);
[pixels_h pixels_w] = size(img_300ppi);
ppi_check = calc_ppi(inches_h, inches_w, pixels_h, pixels_w);
printf ("Pixels Por Polegada da Imagem Reduzida %d.",
        ppi_check);

# Reducao para 150ppi
reduction_factor = 150/ppi;
img_150ppi = imresize(img, reduction_factor);
[pixels_h pixels_w] = size(img_150ppi);
ppi_check = calc_ppi(inches_h, inches_w, pixels_h, pixels_w);
printf ("Pixels Por Polegada da Imagem Reduzida %d.",
        ppi_check);

# Reducao para 72ppi
reduction_factor = 72/ppi;
img_72ppi = imresize(img, reduction_factor);
[pixels_h pixels_w] = size(img_72ppi);
ppi_check = calc_ppi(inches_h, inches_w, pixels_h, pixels_w);
printf ("Pixels Por Polegada da Imagem Reduzida %d.",
        ppi_check);
        
        
# Salvar as Imagens
imwrite(img_300ppi, 'relogio300.tif');
imwrite(img_150ppi, 'relogio150.tif');
imwrite(img_72ppi, 'relogio72.tif');