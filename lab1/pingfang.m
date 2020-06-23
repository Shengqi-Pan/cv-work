% 平方变换
img = imread('haze.jpg');
img = double(img);
imgout = img .^ 2 / 256;

%显示原图像
subplot(2, 1, 1);
imshow(uint8(img));
title('原图像');

%显示变换后的图像
subplot(2, 1, 2);
imshow(uint8(imgout));
title('平方变换后的图像');