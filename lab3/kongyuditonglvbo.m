%%%实现空域低通滤波%%%
img = imread('test.png');
img = rgb2gray(img);
img = double(img);
[row, col] = size(img);%确定图像大小
kernel = [1/10, 1/10, 1/10; 1/10, 1/5, 1/10; 1/10, 1/10, 1/10];%输入卷积核
imgout = convolve(img, kernel);


subplot(2,1,1);
imshow(uint8(img));
title('原图像');
subplot(2,1,2);
imshow(uint8(imgout));
title('空域低通滤波后的图像');

%%%%实现空域低通滤波
%%%%直接用卷积函数,传入的第一个参数为输入图像，第二个参数为卷积核
function imgout = convolve(imgin, kernel)
    [row, col] = size( imgin );
    [~, kernelsize] = size( kernel );
    r = (kernelsize - 1) / 2;
    rowout = row - 2 * r;  %输出图像大小
    colout = col - 2 * r;  %输出图像大小
    if rowout <= 0 || colout <= 0
        return;
    end
    imgout = zeros(rowout, colout);%初始化输出数组
    for i = 1 : rowout
        for j = 1 : colout
            imgout(i, j) =  max(0, sum(sum(imgin(i : i + 2 * r, j : j + 2 * r).*(kernel))));
        end
    end
end