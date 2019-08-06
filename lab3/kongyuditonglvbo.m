%%%ʵ�ֿ����ͨ�˲�%%%
img = imread('test.png');
img = rgb2gray(img);
img = double(img);
[row, col] = size(img);%ȷ��ͼ���С
kernel = [1/10, 1/10, 1/10; 1/10, 1/5, 1/10; 1/10, 1/10, 1/10];%��������
imgout = convolve(img, kernel);


subplot(2,1,1);
imshow(uint8(img));
title('ԭͼ��');
subplot(2,1,2);
imshow(uint8(imgout));
title('�����ͨ�˲����ͼ��');

%%%%ʵ�ֿ����ͨ�˲�
%%%%ֱ���þ������,����ĵ�һ������Ϊ����ͼ�񣬵ڶ�������Ϊ�����
function imgout = convolve(imgin, kernel)
    [row, col] = size( imgin );
    [~, kernelsize] = size( kernel );
    r = (kernelsize - 1) / 2;
    rowout = row - 2 * r;  %���ͼ���С
    colout = col - 2 * r;  %���ͼ���С
    if rowout <= 0 || colout <= 0
        return;
    end
    imgout = zeros(rowout, colout);%��ʼ���������
    for i = 1 : rowout
        for j = 1 : colout
            imgout(i, j) =  max(0, sum(sum(imgin(i : i + 2 * r, j : j + 2 * r).*(kernel))));
        end
    end
end