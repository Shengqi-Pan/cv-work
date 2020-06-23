img = imread('./source/haze.jpg');
fa = min(min(img));
fb = max(max(img));
gb = 256;
ga = 1;
[row, col, width] = size(img);%��ȡ����ͼ��ĳߴ�
imgout = zeros(row, col, width);%��ʼ���任���ͼ��

%��ʾԭͼ��
subplot(2, 1, 1);
imshow(img);
title('ԭͼ��');

%���лҶ����Ա任
for i = 1:3
    imgout(:, :, i) = ((gb - ga)/(fb(:, :, i) - fa(:, :, i)))*(img(:, :, i)-fa(:, :, i)) + ga;
end

%��ʾ�任���ͼ��
subplot(2, 1, 2);
imshow(uint8(imgout));
title('�Ҷ����Ա任���ͼ��');