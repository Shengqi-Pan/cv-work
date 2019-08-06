%%%�������ֶκ�����α��ɫ�任
img = imread('test.png');
img = rgb2gray(img);
img = double(img);            %����תΪdouble���ٴ�������ᵼ�¼���ʱ�������
[row, col] = size(img);       %ȷ��ͼ���С
imgout = zeros(row, col, 3);   %��ʼ�����ͼ��
max_grayscale = max(img(:));  %ȷ�����Ҷ�ֵ�Ĵ�С
for i = 1:row
        for j = 1:col
                grayscale = img(i, j);
        [R, G, B] = gray2rgb(grayscale, max_grayscale);
        imgout(i, j, 1:3) = [R, G, B];
        end
end
%%%��ʾͼ��
subplot(2, 1, 1);
imshow(uint8(img));
title('ԭͼ��');
subplot(2, 1, 2);
imshow(uint8(imgout));
title('α��ɫ�任ͼ��');
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