%%%离散（查表）伪彩色变换
img = imread('./source/test.png');
img = rgb2gray(img);
[row, col] = size(img);       %确定图像大小
imgout = zeros(row, col, 3);   %初始化输出图像
max_grayscale = max(img(:));  %确定最大灰度值的大小
step = double(max_grayscale / 16);    %分为16档
for i = 1 : row
	for j = 1 : col
		scale = ceil(double(img(i, j))/step);
		imgout(i, j, 1:3) = QBcolor(scale); 
	end
end
%%%显示图像
subplot(2, 1, 1);
imshow(img);
title('原图像');
subplot(2, 1, 2);
imshow(uint8(imgout));
title('伪彩色变换图像');
%%%输入灰度级数，输出对应的RGB值
function y = QBcolor(n)
	switch n
		case 1
			y = [1, 1, 1];
		case 2
			y = [1, 1, 192];
		case 3
			y = [1, 192, 1];
		case 4
			y = [1, 192, 192];
		case 5
			y = [192, 1, 1];
		case 6
			y = [192, 1 ,192];
		case 7
			y = [192, 192, 1];
		case 8
			y = [192, 192, 192];
		case 9
			y = [65, 65, 65];
		case 10
			y = [1, 1, 256];
		case 11
			y = [1, 256 ,1];
		case 12
			y = [1, 256, 256];
		case 13
			y = [256, 1, 1];
		case 14
			y = [256, 1, 256];
		case 15
			y = [256, 256, 1];
		case 16
			y = [256, 256, 256];
	end
end