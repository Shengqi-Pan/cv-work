%%%��ɢ�����α��ɫ�任
img = imread('./source/test.png');
img = rgb2gray(img);
[row, col] = size(img);       %ȷ��ͼ���С
imgout = zeros(row, col, 3);   %��ʼ�����ͼ��
max_grayscale = max(img(:));  %ȷ�����Ҷ�ֵ�Ĵ�С
step = double(max_grayscale / 16);    %��Ϊ16��
for i = 1 : row
	for j = 1 : col
		scale = ceil(double(img(i, j))/step);
		imgout(i, j, 1:3) = QBcolor(scale); 
	end
end
%%%��ʾͼ��
subplot(2, 1, 1);
imshow(img);
title('ԭͼ��');
subplot(2, 1, 2);
imshow(uint8(imgout));
title('α��ɫ�任ͼ��');
%%%����Ҷȼ����������Ӧ��RGBֵ
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