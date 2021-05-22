#{
  Autor: Raphael de Lima Mendes
  Descricao: Script da Pratica 2 - Componentes Conexos    
#}
########################################################
##################### Exercicio 1 ######################
########################################################

# Limpar ambiente
clear;
# Variável global para busca em profundidade no grafo 

global visited;
img = imread('imagens/art8.png');
[M N] = size(img);

# Mostrar Imagem, convertendo para Escala de Cinza.
img_b_w = zeros(size(img),"uint8");
img_b_w = img*255;
imshow(img_b_w);

# Funçao recursiva de busca em profundidade em grafo
function DFS(label_equivalency, label)
  global visited;
  visited(label,1) = 1;
  [M_ N_] = size(label_equivalency);
  for i = 1:M_
    if (and(visited(i,1) == 0, label_equivalency(label,i)==1))
      DFS(label_equivalency, i);
    endif
  endfor  
endfunction

function labels_aux = connected_components(img, M, N)
  # Logica para criar componentes conexos
  global visited;
  label_count = 1;
  labels = zeros(size(img),"uint8"); # Matriz placeholder que transforma os pixels em rotulos
  label_equivalency = zeros([255 255],"uint8"); # Matriz de equivalencia dos rotulos

  for row = 1:M
    for col = 1:N
      p = img(row, col);
      if p == 0
        labels(row, col) = 0;
      else
        # Tratando casos de erro, onde p eh um pixel de borda.
        if (row-1 == 0)
          r = 0;
        else
          r = img(row-1, col);
        endif
        if (col-1 == 0)
          t = 0;
        else
          t = img(row, col-1);
        endif
        # Rotula p baseado em r e t
        if (!or(r,t))
          labels(row, col) = label_count;
          label_count = label_count + 1;
        elseif (xor(r,t))
          if (r == 1)
            if labels(row, col) == 0
              labels(row, col) = labels(row-1, col);
            endif
          else
            if labels(row, col) == 0
              labels(row, col) = labels(row, col-1);
            endif
          endif
        elseif (and(r,t))
          if labels(row, col-1) == labels(row-1, col)
            label = labels(row, col-1);
            labels(row, col) = label;
          else
            label = labels(row, col-1);
            labels(row, col) = label;
            # Cria equivalencia na matriz de equivalencia que representa um grafo
            label_equivalency(labels(row, col-1),labels(row-1, col)) = 1; 
            label_equivalency(labels(row-1, col),labels(row, col-1)) = 1;                   
          endif
        endif
      
      endif

    endfor
  endfor
  
  # Descobrir quais os rotulos equivalentes
  # caso haja um caminho entre os rotulos, entao eles
  # sao equivalentes. Utiliza-se o menor valor de rótulo para nomear 
  # por convenção
  labels_aux = labels;
  for row = 1:M
    for col = 1:N
      if labels(row, col) != 0
        visited = zeros([M,1],"uint8");
        DFS(label_equivalency, labels(row, col));
        i = 1;
        while (visited(i,1) == 0)
          i += 1;
        endwhile
        labels_aux(row, col) = i;
      endif
    endfor
  endfor
endfunction
tic();
labels_aux = connected_components(img, M, N);
elapsed = toc();
printf('tempo para encontrar componentes conexas: %f', elapsed)
# Mostrar Imagem após encontrar os componentes conexos;
imshow(labels_aux);

# Colorir Imagem usando valores aleatórios de RGB para cada componente
# conexa
color_img = zeros([M N 3],"uint8");
labels = unique(labels_aux);
[S V] = size(labels);
printf("Numero de componentes: %d", S-1); # exclui o 0

for i = 1:S
  R = randi(255);
  G = randi(255);
  B = randi(255);
  for p_y = 1:M
    for p_x = 1:N
      if labels_aux(p_x, p_y) == 0
        color_img(p_x, p_y, 1) = 0;
        color_img(p_x, p_y, 2) = 0;
        color_img(p_x, p_y, 3) = 0;
      elseif labels_aux(p_x, p_y) == labels(i,1)
        color_img(p_x, p_y, 1) = R;
        color_img(p_x, p_y, 2) = G;
        color_img(p_x, p_y, 3) = B;
      endif
    endfor
  endfor
endfor

imshow(color_img);


########################################################
##################### Exercicio 2 ######################
########################################################

img = imread('imagens/clc3.png');
[M N] = size(img);
# Aplicar limiar para transformar em imagem P&B;
img_bw = img > 67;
imshow(img_bw);

# Contar número de componentes conexos
tic();
labels_aux = connected_components(img_bw, M, N);
elapsed = toc();
printf('tempo para encontrar componentes conexas: %f', elapsed)
imshow(labels_aux);

labels = unique(labels_aux);
[S V] = size(labels);
printf("Numero de componentes: %d", S-1); # exclui o 0
########################################################
##################### Exercicio 3 ######################
########################################################
pkg load image;
# Usando vizinhanca 4

### Imagem 1 ###
tic();
labels_aux_octave = bwconncomp(img_b_w, 4);
elapsed = toc();
printf("Numero de componentes: %d",  getfield(labels_aux_octave,'NumObjects'));
printf('tempo para encontrar componentes conexas: %f', elapsed);

### Imagem 2 ###
tic();
labels_aux_octave = bwconncomp(img_bw, 4);
elapsed = toc();
printf("Numero de componentes: %d",  getfield(labels_aux_octave,'NumObjects'));
printf('tempo para encontrar componentes conexas: %f', elapsed);

#### Conclusão ###
# O Matlab tem um algoritmo mais eficiente, mais de 1000x mais rápido no exercicio 2
# Os resultados são iguais;

