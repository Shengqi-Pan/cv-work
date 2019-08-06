%%%��򷨣���ֵ�ָ
img = imread('fruit.png');
img = rgb2gray(img);
bestg_k = 0;
bestTh = mean(img( : ));        %�趨�ҶȾ�ֵΪ��ʼ��ֵ
for Th = 1 : 256
    %С����ֵ�Ĳ���
    pic1 = img;
    pic1(pic1 > Th) = 0;
    miu1 = mean(pic1( : ));
    n1 = sum(sum(pic1 ~= 0));
    %������ֵ�Ĳ���
    pic2 = img;
    pic2(pic2 < Th) = 0;
    miu2 = mean(pic2( : ));
    n2 = sum(sum(pic2 ~= 0));
    %������෽��
    g_k = n1 * n2 * (miu1 - miu2) ^ 2;
    %��ȡ��Ŀǰ�Դ����ֵʱ�����������ֵ
    if g_k > bestg_k
        bestTh = Th;
        bestg_k = g_k;
    end
end
imgout = img;
imgout(imgout < bestTh) = 1;
imgout(imgout > bestTh) = 256;
%%%��ʾͼ��
subplot(2, 1, 1);
imshow(img);
title('ԭͼ��');
subplot(2, 1, 2);
imshow(uint8(imgout));
title('���ͼ��');