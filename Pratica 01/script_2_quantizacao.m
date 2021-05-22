#{
  Autor: Raphael de Lima Mendes
  Descricao: Script da Pratica 1 - Quantizacao    
#}

clear;

function q_img = quantize_image(img, bits)
  [M N] = size(img);
  levels = 2^bits;
  # Limiar de cada intervalo
  threshold = 256/levels;
  # Calcula os intervalos
  subdivisions = (1:levels)*threshold;
  q_img = zeros(size(img),"uint8");
  # Iterar sobre matriz para saber qual intervalo o valor pertence
  for i = 1:M
    for j = 1:N
      for k = 1:levels
        if (img(i,j) <= subdivisions(1,k))
          q_img(i,j) = subdivisions(1,k);
          break
        endif
      endfor
    endfor
  endfor
  return;
endfunction


clf;
img = imread('ctskull-256.tif');
# Grid
r = 2;
c = 4;
fmt = {"horizontalalignment", "center", "verticalalignment", "middle"};
# Plotar uma imagem por bit de 1 a 8
for n = 1 : r*c
  subplot (r, c, n);
  title (sprintf ("Bits: %d", n));
  hold on;
  imshow(quantize_image(img, n));
  hold off;
endfor
 