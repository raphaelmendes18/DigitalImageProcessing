% Cálculo da equalização de histograma
img = imread('im_cells.png');
L = 255;
[M N] = size(img);
n = M*N;
hist_ = imhist(img);
Pr = hist_/sum(hist_);
cdf = cumsum(Pr);
Tr = cdf .* L;
Sk = round(Tr); 

eq_img = zeros(M,N);
for i = 1:M
    for j = 1:N
      eq_img(i,j) = Sk(img(i,j)+1);
    end
end

imshow(uint8(eq_img))
