% �޷��Ҷ�����
img = imread('./haze.jpg');
img = rgb2gray(img);
fa = floor(min(min(img)) + 10);
fb = floor(max(max(img)) - 10);
gb = 256;
ga = 1;
[row, col] = size(img);%��ȡ����ͼ��ĳߴ�
% imgout = zeros(row, col);%��ʼ���任���ͼ��

%��ʾԭͼ��
subplot(2, 1, 1);
imshow(img);
title('ԭͼ��');

imgout = img;
imgout(imgout > fb) = 1;
imgout(imgout < fa) = 256;
for i = 1 : row
    for j = 1 : col
        if imgout(i, j) > fa && imgout(i, j) < fb
            imgout(i, j) = ((gb - ga)/(fb - fa))*(img(i, j) - fa) + ga;
        end
    end
end

%��ʾ�任���ͼ��
subplot(2, 1, 2);
imshow(uint8(imgout));
title('�Ҷ��޷�������ͼ��');