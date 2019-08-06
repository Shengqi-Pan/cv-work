%%%%��ֵƽ��%%%%
img = imread('test.png');
img = rgb2gray(img);
img = double(img);
[row, col] = size(img);     %ȷ��ͼ���С
imgAvg = sum(sum(img)) / (row * col);   %���ֵ

subplot(2,1,1);
imshow(uint8(img));
title('ԭͼ��');
subplot(2,1,2);
imgTh = pinghuaTh(img, 20, 3);
imshow(uint8(imgTh));
title('��ֵƽ�����ͼ��');
for Th = 0 : 10 : 20
    for window = 3 : 2 : 7
        imgTh = pinghuaTh(img, Th, window);
        i = ((window - 1) / 2 - 1) * 3 + Th / 10 + 1;%��ǰ�ǵ�i��ͼ
        subplot(3,3,i);
        imshow(uint8(imgTh));
        title(['Th = ', num2str(Th), ' window = ', num2str(window)]);
    end
end

%%%%ʵ����ֵƽ��
%%%%�����ĵ�һ������Ϊͼ�񣬵ڶ�������Ϊ��ֵ������������Ϊ���ڴ�С
function imgTh = pinghuaTh(img, Th, window)
    imgTh = img;
    [row, col] = size(imgTh); 
    for i = (window - 1)/2 + 1 : (col - (window - 1)/2)%��������
        for j = (window - 1)/2 + 1 : (row - (window - 1)/2)%��������
            imgThAvg = sum(reshape(imgTh(j - (window - 1) / 2 : j + (window - 1) / 2, i - (window - 1)/2 : i + (window - 1)/2), [1,window * window])) / (window * window);
            if abs(imgTh(j, i) - imgThAvg) > Th
                imgTh(j, i) = imgThAvg;
            end
        end
    end
end
%%%%ʵ�ֿ����ͨ�˲�