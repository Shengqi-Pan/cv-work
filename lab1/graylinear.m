img = imread('./source/haze.jpg');
fa = min(min(img));
fb = max(max(img));
gb = 256;
ga = 1;
[row, col, width] = size(img);%获取输入图像的尺寸
imgout = zeros(row, col, width);%初始化变换后的图像

%显示原图像
subplot(2, 1, 1);
imshow(img);
title('原图像');

%进行灰度线性变换
for i = 1:3
    imgout(:, :, i) = ((gb - ga)/(fb(:, :, i) - fa(:, :, i)))*(img(:, :, i)-fa(:, :, i)) + ga;
end

%显示变换后的图像
subplot(2, 1, 2);
imshow(uint8(imgout));
title('灰度线性变换后的图像');