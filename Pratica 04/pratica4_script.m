% Raphael de Lima Mendes

% Exercicio 1A - Filtragem de M�dia
[img map] = imread("sta2.png");
img_gray = ind2gray(img, map);
subplot(2,2,1);
title (sprintf ("Imagem Original"));
hold on;
imshow(img_gray);
hold off;
subplot(2,2,2);
title (sprintf ("Imagem Filtrada 3x3"));
hold on;
imshow(avgFilter(img_gray, 3));
hold off;
subplot(2,2,3);
title (sprintf ("Imagem Filtrata 7x7"));
hold on;
imshow(avgFilter(img_gray, 7));
hold off;
subplot(2,2,4);
title (sprintf ("Imagem Filtrata 3x3 3x"));
hold on;
imshow(avgFilter(avgFilter(avgFilter(img_gray, 3),3),3));

% Exerc�cio 1B - Filtragem Gaussiana
[img map] = imread("ben2.png");
img_gray = ind2gray(img, map);
subplot(2,4,1);
title (sprintf ("Imagem Original"));
hold on;
imshow(img_gray);
hold off;
subplot(2,4,2);
title (sprintf ("Imagem sigma (s=1.0,k=5x5)"));
hold on;
mask = generateGaussianKernel(5,1);
imshow(gaussianFilter(img_gray,5,mask));
hold off;
subplot(2,4,3);
title (sprintf ("Imagem sigma (s=2.0,k=9x9)"));
hold on;
mask = generateGaussianKernel(9,2);
imshow(gaussianFilter(img_gray,9,mask));
hold off;
subplot(2,4,4);
title (sprintf ("Imagem sigma (s=4.0,k=15x15)"));
hold on;
mask = generateGaussianKernel(15,4);
imshow(gaussianFilter(img_gray,15,mask));
hold off;

[img map] = imread("sta2noi2.png");
img_gray = ind2gray(img, map);
subplot(2,4,5);
title (sprintf ("Imagem Original"));
hold on;
imshow(img_gray);
hold off;
subplot(2,4,6);
title (sprintf ("Imagem sigma (s=1.0,k=5x5)"));
hold on;
mask = generateGaussianKernel(5,1);
imshow(gaussianFilter(img_gray,5,mask));
hold off;
subplot(2,4,7);
title (sprintf ("Imagem sigma (s=2.0,k=9x9)"));
hold on;
mask = generateGaussianKernel(9,2);
imshow(gaussianFilter(img_gray,9,mask));
hold off;
subplot(2,4,8);
title (sprintf ("Imagem sigma (s=4.0,k=15x15)"));
hold on;
mask = generateGaussianKernel(15,4);
imshow(gaussianFilter(img_gray,15,mask));

% Exerc�cio 1C - Filtro por Mediana
[img map] = imread("sta2noi1.png");
img_gray = ind2gray(img, map);
subplot(2,2,1);
title (sprintf ("Imagem Original"));
hold on;
imshow(img_gray);
hold off;
subplot(2,2,2);
title (sprintf ("Imagem Filtrada 3x3"));
hold on;
imshow(uint8(medianFilter(img_gray, 3,3)));
hold off;
subplot(2,2,3);
title (sprintf ("Imagem Filtrata 7x7"));
hold on;
imshow(uint8(medianFilter(img_gray, 7,7)));

% Exerc�cio 2A - Filtro Roberts
[img map] = imread("cln1.gif");
img_gray = ind2gray(img, map);
imshow(uint8(robertsFilterWithConv(img_gray)));
% Exerc�cio 2B - Filtro Sobel
[img map] = imread("cln1.gif");
img_gray = ind2gray(img, map);
subplot(2,2,1);
imshow(uint8(sobelFilterWithConv(img_gray,1)));
[img map] = imread("cln1.gif");
img_gray = ind2gray(img, map);
subplot(2,2,2);
imshow(uint8(sobelFilterWithConv(img_gray,2)));
% Exerc�cio 2C - Filtro Laplaciano
[img map] = imread("cln1.gif");
img_gray = ind2gray(img, map);
imshow(uint8(laplacianFilter(img_gray,1)));
% Exerc�cio 2D - Filtro Unsharp Masking
[img map] = imread("cln1.gif");
% Unsharp
k=0;
img_gray = ind2gray(img, map);
gMask = double(img_gray) - medianFilter(img_gray, 3,3);
g = double(img_gray) + k.*gMask;
imshow(uint8(g));
% Exerc�cio 2E - Filtro Highboost Filtering
% HB
k=2;
img_gray = ind2gray(img, map);
gMask = double(img_gray) - medianFilter(img_gray, 3,3);
g = double(img_gray) + k.*gMask;
imshow(uint8(g));
% Exerc�cio 2F - Filtro Sobel
[img map] = imread("ufo2.gif");
threshold=150;
img_gray = ind2gray(img, map);
subplot(2,2,1);
filtered_img = sobelFilterWithConv(img_gray,1);
imshow(uint8(filtered_img));
subplot(2,2,2);
filtered_img= uint8(filtered_img).*(uint8(filtered_img >= threshold));
imshow(uint8(filtered_img));
% Exerc�cio 2G - Filtro Sobel
[img map] = imread("ufo2noi2.gif");
threshold=150;
img_gray = ind2gray(img, map);
subplot(2,2,1);
filtered_img = sobelFilterWithConv(img_gray,1);
imshow(uint8(filtered_img));
subplot(2,2,2);
filtered_img= uint8(filtered_img).*(uint8(filtered_img >= threshold));
imshow(uint8(filtered_img));

% Exercicio 3
Os filtros de suavização possuem a finalidade de remover ruídos das imagens, como foi possível observar nos exemplos em que havia imagens granuladas, a suavização foi
capaz de remover boa parte dos ruídos. O quão agressivo a suavização pode ser, dependerá de qual método a ser utilizado e varia caso a caso, neste trabalho o filtro de suavização
por mediana apresentou resultados excelentes.
Os filtros de realce, estão principalmente relacionados a destacar as mudanças de direção na imagem, como contornos e mudanças de contraste. É um ferramenta bastante interessante, e a
flexibilidade do uso de derivadas em diferentes eixos é uma característica que pode ser explorada. O filtro sober é um pouco mais agressivo em relação ao destaque de contornos.
A combinação do uso de um filtro de suavização para gerar o realce, apresentou resultados excelentes e pode ser usado para deixar a imagem com um visual melhor, além disso a possibilidade de ajustar O
realce através da variável K, dá uma flexibilidade interessante para esse tipo de aplicação.
No geral, podemos colocar a suavização a ser utilizada para remoção de ruídos e remoção de características indesejáveis na foto, como por exemplo numa aplicação de embelezamento através da suavização da pele para
eliminar rugas. Os filtros de realce podem ser úteis para aplicações computacionais, como por exemplo, a detecção de limites em objetos.



function result = laplacianFilter(input_image,c)
    laplacian = zeros(size(input_image));
    img = padarray(input_image,[1 1],0);
    
    for i=2:size(input_image,1)
        for j=2:size(input_image,2)
            laplacian(i-1,j-1) = img(i+1,j) + img(i-1,j) + ...
            img(i,j+1) + img(i,j-1) - 4.*img(i,j);
        end
    end
    result = double(input_image) + c*laplacian;
end

function result = sobelFilterWithConv(input_image,direction)
    % Convert the image to double
    input_image = double(input_image);
  
    % Pre-allocate the filtered_image matrix with zeros
    filtered_image = zeros(size(input_image));
    % Robert Operator Mask
    
    Mx = [-1 -2 -1; 0 0 0; 1 2 1]; % Mirror Matrices
    My = [1 0 -1; 2 0 -2; 1 0 -1];
    if (direction == 1)
        Gx = conv2dImage(input_image,3,Mx);
        filtered_image = sqrt(Gx.^2);
    elseif (direction == 2)
        Gy = conv2dImage(input_image,3,My)
        filtered_image = sqrt(Gy.^2);
    else
        Gx = conv2dImage(input_image,3,Mx);
        Gy = conv2dImage(input_image,3,My);
        filtered_image = sqrt(Gx.^2 + Gy.^2);
    end
    result = filtered_image;

end

function result = robertsFilterWithConv(input_image)
    % Convert the image to double
    input_image = double(input_image);
  
    % Pre-allocate the filtered_image matrix with zeros
    filtered_image = zeros(size(input_image));
    % Robert Operator Mask
    
    Mx = [0 0 1; 0 -1 0; 0 0 0]; % Mirror Matrices
    My = [0 1 0; 0 0 -1; 0 0 0];

    Gx = conv2dImage(input_image,3,Mx)
    Gy = conv2dImage(input_image,3,My)
    filtered_image = sqrt(Gx.^2 + Gy.^2);
    result = filtered_image
end

function result = medianFilter(img, dim_x, dim_y)
    a = fix(dim_x/2);
    b = fix(dim_y/2);
    A = padarray(img,[a b],0);
    result = zeros(size(img));
    [M N] = size(A);
    for i=a+1:M-a
        for j=b+1:N-b
            median = medianWindow(A, i, j, dim_x, dim_y);
            result(i-a,j-b) = median;
        end
    end
end

function median = medianWindow(img, x, y, dim_x, dim_y)
    a = fix(dim_x/2);
    b = fix(dim_y/2);
    result = zeros(dim_x*dim_y);
    idx = 1;
    for i=x-a:x+a
        for j=y-b:y+b
           result(idx) = img(i,j);
           idx = idx+1;
        end
    end
    mid = ceil(((dim_x*dim_y)/2));
    median = sort(result(1:idx-1,1));
    median = median(mid,1);
end
        
function result = generateGaussianKernel(dim, sigma)
    a = fix(dim/2);
    b = fix(dim/2);
    result = zeros(dim,dim);
    for x=-a:a
        for y=-b:b
            result(x+a+1, y+b+1) = GaussXY(x,y,sigma);
        end
    end
    
    result = result./sum(result(:));
end

function g = GaussXY(x,y,sigma)
    fator = (1/sqrt(2*pi*(sigma^2)));
    g = fator*exp(-(x.^2 + y.^2)/(2*(sigma.^2)));
end

function convWindow = conv2d(img, kernel, start_i, start_j)
    [M N] = size(kernel);
    padding_x = floor(M/2);
    padding_y = floor(N/2);
    A = padarray(img,[padding_x padding_y],0);
    c = zeros(size(kernel));
    for i=start_i+padding_x:(start_i + padding_x+M -1)
        for j=start_j+padding_y:(start_j+padding_y+N-1)
            v = A(i-padding_x:i+padding_x,j-padding_y:j+padding_y);
            v = double(v);
            c(i-(start_i+padding_x) + 1,j-(start_j+padding_y) + 1) = sum((v.*kernel),'all');
        end
    end

    convWindow = c;
end

function filteredImage = avgFilter(img, dim)
    [M N] = size(img);
    padding_x = ceil(M/dim)*dim - M;
    padding_y = ceil(N/dim)*dim - N;
    img = padarray(img,[padding_x padding_y],0,'post');
    kernel = ones([dim dim]);
    kernel = (1/(dim*dim))*kernel;
    filteredImage = zeros(size(img));
    for i = 1:dim:M
        for j = 1:dim:N
            filteredImage(i:i+dim-1,j:j+dim-1) = ceil(conv2d(img, kernel,i,j));
        end
    end
    [M N] = size(img)
    filteredImage = uint8(filteredImage(1:M-padding_x,1:N-padding_y));
end

function filteredImage = gaussianFilter(img, dim, kernel)
    [M N] = size(img);
    padding_x = ceil(M/dim)*dim - M;
    padding_y = ceil(N/dim)*dim - N;
    img = padarray(img,[padding_x padding_y],0,'post');
    filteredImage = zeros(size(img));
    for i = 1:dim:M
        for j = 1:dim:N
            filteredImage(i:i+dim-1,j:j+dim-1) = ceil(conv2d(img, kernel,i,j));
        end
    end
    [M N] = size(img)
    filteredImage = uint8(filteredImage(1:M-padding_x,1:N-padding_y));
end

function filteredImage = conv2dImage(img, dim, kernel)
    [M N] = size(img);
    padding_x = ceil(M/dim)*dim - M;
    padding_y = ceil(N/dim)*dim - N;
    img = padarray(img,[padding_x padding_y],0,'post');
    filteredImage = zeros(size(img));
    for i = 1:dim:M
        for j = 1:dim:N
            filteredImage(i:i+dim-1,j:j+dim-1) = ceil(conv2d(img, kernel,i,j));
        end
    end
    [M N] = size(img)
    filteredImage = (filteredImage(1:M-padding_x,1:N-padding_y));
end


