%%%��ֵ����
img = imread('./source/zaosheng.png');
img = rgb2gray(img);
[row, col] = size(img);%ȷ��ͼ���С
window = 3;
result = zeros(row-(window-1), col-(window-1));
for i = 2:(col - (window - 1)/2)%��������
    for j = 2:(row - (window - 1)/2)%��������
        result(j-1,i-1) = min(reshape(img(j-1:j+1, i-1:i+1), [1,9]));
    end
end
subplot(2,1,1)
imshow(img);
title('ԭͼ��');
subplot(2,1,2)
imshow(uint8(result));
title('��ֵ�˲�ͼ��');