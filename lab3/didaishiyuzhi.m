%%%����ʽ��ֵѡ�񣨶�ֵ�ָ
img = imread('dog.png');
img = rgb2gray(img);
Th = mean(img( : ));            %���ҶȾ�ֵ��Ϊ��ʼ��ֵ
newTh = 0;
i = 1;
while (Th - newTh) > 1
    pic1 = img;
    pic1(pic1 > Th) = 0;            %������ֵ���㷽�����ֵ
    miu1 = mean(pic1(:));        %С����ֵ�����صĻҶȾ�ֵ
    pic2 = img;
    pic2(pic2 < Th) = 0;            %С����ֵ���㷽�����ֵ 
    miu2 = mean(pic2( : ));      %������ֵ�����صĻҶȾ�ֵ
    if i ~= 1
        Th = newTh; 
    end
    i = i + 1;
    newTh = (miu1 + miu2) / 2;
end
imgout = img;
imgout(imgout < Th) = 1;
imgout(imgout > Th) = 256;
%%%��ʾͼ��
subplot(2, 1, 1);
imshow(img);
title('ԭͼ��');
subplot(2, 1, 2);
imshow(uint8(imgout));
title('������ֵ��ͼ��');