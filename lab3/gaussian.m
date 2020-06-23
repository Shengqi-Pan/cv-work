%%%ʵ�ֿ����ͨ�˲�%%%
img = imread('./source/test.png');
img = rgb2gray(img);
img = double(img);
[row, col] = size(img);%ȷ��ͼ���С
kernel = [0.11, 0.2, 0.29, 0.32, 0.29, 0.2, 0.11; ...
          0.2, 0.37, 0.54, 0.61, 0.54, 0.37, 0.2; ...
          0.29, 0.54, 0.78, 0.88, 0.78, 0.54, 0.29; ...
          0.32, 0.61, 0.88, 1, 0.88, 0.61, 0.32; ...
          0.29, 0.54, 0.78, 0.88, 0.78, 0.54, 0.29; ...
          0.2, 0.37, 0.54, 0.61, 0.54, 0.37, 0.2; ...
          0.11, 0.2, 0.29, 0.32, 0.29, 0.2, 0.11]/21.52;%��������
imgout = convolve(img, kernel);


subplot(2,1,1);
imshow(uint8(img));
title('ԭͼ��');
subplot(2,1,2);
imshow(uint8(imgout));
title('��˹�˲����ͼ��');

%%%%ʵ�ָ�˹�˲�
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