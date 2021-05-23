%%%%%%%%%% Pratica 04 %%%%%%%%%
%%%% Morfologia Matematica %%%%
%%%%%%% Raphael L Mendes %%%%%%

%% Testes %%
%A = [0 0 0 0 ;0 1 1 0 ; 0 1 1 0; 0 0 0 0]
%B = [1 1]
%A = [zeros(1,13);zeros(1,13);zeros(1,13);0 0 0 1 1 1 1 1 1 1 0 0 0;0 0 0 1 1 1 1 1 1 1 0 0 0;0 0 0 1 1 1 1 1 1 1 0 0 0;zeros(1,13);zeros(1,13);zeros(1,13)];
%B = ones(3,3);

% A = zeros(12,12);
% A(5,8) = 1;
% A(6,3) = 1;
% A(6,4) = 1;
% A(6,5) = 1;
% A(6,7) = 1;
% A(6,8) = 1;
% A(6,9) = 1;
% A(7,3) = 1;
% A(7,4) = 1;
% A(7,5) = 1;
% A(7,7) = 1;
% A(7,8) = 1;
% A(7,9) = 1;
% A(8,3) = 1;
% A(8,4) = 1;
% A(8,5) = 1;
% A(8,6) = 1;
% A(8,7) = 1;
% A(8,8) = 1;
% A(8,9) = 1;
% A(9,5) = 1;

% erosion(A,B,2,2)
% aperture(A,B,2,2);

%%%% Questao 1 %%%%
[img map] = imread("art3.gif");
img_gray = ind2gray(img, map);
img_gray_binary = (img_gray >= 1)*1;
% imshow(imread('art3.gif'))

% Create a logical image of a circle with specified
% diameter, center, and image size.
% First create the image.
imageSizeX = 11;
imageSizeY = 11;
[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
% Next create the circle in the image.
centerX = imageSizeX / 2; % Wherever you want.
centerY = imageSizeY / 2;
radius = 5.5;
circlePixels = (rowsInImage - centerY).^2 ...
    + (columnsInImage - centerX).^2 <= radius.^2;

results = aperture(img_gray_binary,circlePixels, 6,6)
imshow(results*255)
% 
% %%%% Questao 2a %%%%
[img map] = imread("art2.gif");
img_gray = ind2gray(img, map);
img_gray_binary = (img_gray >= 1)*1;
B = ones(9,3);
results = aperture(img_gray_binary,B, 5,2)
imshow(results*255)
% 
% 
% %%%% Questao 2b %%%%
[img map] = imread("art2.gif");
img_gray = ind2gray(img, map);
img_gray_binary = (img_gray >= 1)*1;
B = ones(3,9);
results = aperture(img_gray_binary,B, 2,5)
imshow(results*255)

%%%% Questao 3 %%%%
[img map] = imread("cel4.gif");
img_gray = ind2gray(img, map);
img_gray_binary = uint8((img_gray >= 210)*1);
img_gray_binary = medianFilter(img_gray_binary,15,15)
results = aperture(img_gray_binary,circlePixels,6,6)
imshow(results*255)
% imshow(results*255)

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


function result = erosion(A, B, o_x, o_y)
    % A é a imagem de entrada
    % B é o elemento estruturante
    [M,N] = size(A);
    result = A;
    for i=1:M
        for j=1:N
            result(i+1,j+1) = erosion_op(A, B, i, j, o_x, o_y);
        end
    end
    result = result(2:M+1,2:N+1);
end

function result = erosion_op(A, B, i, j, o_x, o_y)
    [M,N] = size(A);
    [M_b, N_b] = size(B);
    for k=1:M_b
        for l=1:N_b
            if (i+k-o_x) <= 0 || (j+l-o_y) <= 0 || B(k,l) == 0
                continue
            end
            if (i+k-o_x) >= M || (j+l-o_y) >= N
                result = 0;
                return
            end
            if (A(i+k-o_x,j+l-o_y) == 0)
                result = 0;
                return
            end
        end
    end
    result = 1;
    return
end

function result = dilation(A, B, o_x, o_y)
    % A é a imagem de entrada
    % B é o elemento estruturante
    [M,N] = size(B);
    result = zeros(size(A));
    for i=1:M
        for j=1:N
            if B(i,j) > 0
                result = union(result, dilation_op(A, B, i, j, o_x, o_y));
            end
        end
    end
end

function result = dilation_op(A, B, b_i, b_j, o_x, o_y)
    [M,N] = size(A); 
    result = zeros(size(A));
    for i=1:M
        for j=1:N
            if (i+b_i-o_x) <= 0 || (j+b_j-o_y) <= 0
                continue
            end
            if A(i, j) ~= 0
                result(i+b_i-o_x,j+b_j-o_y) = 1;
            else
                result(i+b_i-o_x,j+b_j-o_y) = 0;
            end
        end
    end
    result = result(1:M,1:N);
    return
end 

function result = union(A,B)
    result = A + B;
    result = (result >= 1)*1;
end

function result = aperture(A, B, o_x, o_y)
    result = dilation(erosion(A,B,o_x, o_y),B,o_x, o_y)
end
