%%%连续（分段函数）伪彩色变换
img = imread('test.png');
img = rgb2gray(img);
img = double(img);            %必须转为double后再处理，否则会导致计算时数据溢出
[row, col] = size(img);       %确定图像大小
imgout = zeros(row, col, 3);   %初始化输出图像
max_grayscale = max(img(:));  %确定最大灰度值的大小
for i = 1:row
        for j = 1:col
                grayscale = img(i, j);
        [R, G, B] = gray2rgb(grayscale, max_grayscale);
        imgout(i, j, 1:3) = [R, G, B];
        end
end
%%%显示图像
subplot(2, 1, 1);
imshow(uint8(img));
title('原图像');
subplot(2, 1, 2);
imshow(uint8(imgout));
title('伪彩色变换图像');
function [R, G, B] = gray2rgb(n, L)
        if n < L/4
                R = 1;
                G = 256*4/L*n;
                B = 256;
        elseif n < L/2
                R = 256*2/L*(n-L/4);
                G = 256;
                B = 256-256*4/L*(n-L/4);
        elseif n < 3*L/4
                R = 256*2/L*(n-L/4);
                G = 256;
                B = 1;
        else
                R = 256;
                G = 256-256*4/L*(n-(3*L)/4);
                B = 1;
        end
end