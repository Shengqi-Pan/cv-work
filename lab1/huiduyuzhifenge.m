% 灰度阈值分割
img = imread('./fruit.png');
img = rgb2gray(img);

% 显示原图像
subplot(2, 1, 1);
imshow(img);
title('原图像');

Th = 205;  % 设定阈值
imgout = img;
imgout(imgout < Th) = 1;
imgout(imgout > Th) = 256;


% 显示变换后的图像
subplot(2, 1, 2);
imshow(imgout);
title('阈值灰度分割后的图像');