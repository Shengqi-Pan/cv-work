%%%ͼ��Ĳ㼶��ʾ
img = imread('hasaki.png');
img = rgb2gray(img);
[row, col] = size(img);       %ȷ��ͼ���С
imgsize = row;                %imgsizes��ѹ����Ĵ�С
lastimage = double(img);              %��ʼ��lastimage
%��ʾԭͼ
subplot(2, 5, 1);
imshow(img);
title('ԭͼ');

i = 1;
while imgsize ~= 1
    imgsize = imgsize/2;
    imgout = zeros(imgsize, imgsize);   %��ʼ�����ͼ��
    for j = 1 : imgsize                %��ѹ�����ͼ���ֵ
        for k = 1 : imgsize
            former_j = 2 * j - 1;       %ѹ�����±�j����Ӧѹ��ǰ���±�
            former_k = 2 * k - 1;       %ѹ�����±�k����Ӧѹ��ǰ���±�
            imgout(j, k) = (lastimage(former_j, former_k) + ...
                            lastimage(former_j + 1, former_k) + ...
                            lastimage(former_j, former_k + 1) + ...
                            lastimage(former_j + 1, former_k + 1)) / 4;
        end
    end
    subplot(2, 5, i + 1);
    imshow(uint8(imgout));
    title(['��', num2str(i), '�δ���']);

    i = i + 1;
    lastimage = imgout;
    lastsize = imgsize;
end
