clc;
clear;
close all;

% ��ʼ��
rgbimg = imread('test3.jpg');
% figure;
imshow(rgbimg);
r = rgbimg(:, :, 1);
g = rgbimg(:, :, 2);
b = rgbimg(:, :, 3);

grayimg = rgb2gray(rgbimg);
[row, col] = size(grayimg);%����������

hsvimg = rgb2hsv(rgbimg);
H = hsvimg(:, :, 1);
S = hsvimg(:, :, 2);
V = hsvimg(:, :, 3);
% ��ʼ��

I = H;%��ȡHɫ�ʿռ�
% hy = fspecial('sobel');%sobel����
% hx = hy';
% Iy = imfilter(double(I), hy, 'replicate');%�˲���y�����Ե
% Ix = imfilter(double(I), hx, 'replicate');%�˲���x�����Ե
% gradmag = sqrt(Ix.^2 + Iy.^2);%����

% ��ֵ�ָ�
% �ֱ��ǰ���ͱ������б�ǣ�ʹ����̬ѧ�ؽ�������ǰ��������б�ǣ�����ʹ�ÿ�������������֮�����ȥ��һЩ��С��Ŀ�ꡣ
se = strel('disk', 40);%Բ�νṹԪ��
% ��ʴ
Io = imopen(I, se);%��̬ѧ������
Ie = imerode(I, se);%��ͼ����и�ʴ
Iobr = imreconstruct(Ie, I);%��̬ѧ�ؽ�
% ����
Ioc = imclose(Io, se);%��̬ѧ�ز���
Iobrd = imdilate(Iobr, se);%��ͼ���������
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));%��̬ѧ�ؽ�
Iobrcbr = imcomplement(Iobrcbr);%ͼ����
bw = imbinarize(Iobrcbr, graythresh(Iobrcbr));%ת��Ϊ��ֵͼ��
bw = imcomplement(bw);%ͼ����
% figure;
imshow(bw) %��ʾ��ֵͼ��
title('Thresholded opening-closing by reconstruction')
% ��ֵ�ָ�

% ������
XProject = sum(bw);%��ֵͼ��x���ͶӰ
YProject = sum(bw, 2);%��ֵͼ��y���ͶӰ
XProjectSum = XProject;
YProjectSum = YProject;
for i = 2 : col
    XProjectSum(i) = XProjectSum(i) + XProjectSum(i-1);
end
for i = 2 : row
    YProjectSum(i) = YProjectSum(i) + YProjectSum(i-1);
end
%��ͼ
XAxis = 1 : col;
YAxis = 1 : row;
figure;
bar(XAxis, XProjectSum);
title('x���ۻ�ֱ��ͼ');
figure;
bar(YAxis, YProjectSum);
title('y���ۻ�ֱ��ͼ');
% �ֱ���x��y������
XHalf = sum(XProject)/2;%��x��һ��
YHalf = sum(YProject)/2;%��y��һ��
for i = 2 : col
    if XHalf > XProjectSum(i-1) && XHalf < XProjectSum(i)
        break;
    end
end
XCenter = i;%x������
for i = 2 : row
    if YHalf > YProjectSum(i-1) && YHalf < YProjectSum(i)
        break;
    end
end
YCenter = i;%y������
bwCenter = bw;
bwCenter(YCenter - 5 : YCenter + 5, XCenter - 5 : XCenter + 5) = 0;
figure;
imshow(bwCenter);
% ������

% ��뾶
for i = XCenter : col
    if bw(YCenter, i) == 0
        break;
    end
end
RXR = i - XCenter;
for i = XCenter : -1 : 1
    if bw(YCenter, i) == 0
        break;
    end
end
RXL = XCenter - i;
R = (RXR + RXL) / 2;
% ��뾶

% ���ݰ뾶���ROI
RecLDown = [floor(YCenter - R / 2), floor(XCenter - R / 2)];%�������½ǵĵ�ΪRecLDown
RecRDown = [floor(YCenter - R / 2), floor(XCenter + R / 2)];%�������½ǵĵ�ΪRecRDown
RecLUp = [max(1, floor(YCenter - R / 2 - R)), floor(XCenter - R / 2)];%�������Ͻǵĵ�ΪRECLUp
RecRUp = [max(1, floor(YCenter - R / 2 - R)), floor(XCenter + R / 2)];%�������Ͻǵĵ�ΪRecRUp
ROI = bw(RecLUp(1) : RecRDown(1), RecLDown(2) : RecRUp(2));
figure;
imshow(ROI);
% ���ݰ뾶���ROI

% ��ROI���д���
[ROIrow, ROIcol] = size(ROI);
ROIXProject = sum(ROI);%��ֵͼ��x���ͶӰ
ROIYProject = sum(ROI, 2);%��ֵͼ��y���ͶӰ
ROIXProjectSum = ROIXProject;
ROIYProjectSum = ROIYProject;
for i = 2 : ROIcol
    ROIXProjectSum(i) = ROIXProjectSum(i) + ROIXProjectSum(i-1);
end
for i = 2 : ROIrow
    ROIYProjectSum(i) = ROIYProjectSum(i) + ROIYProjectSum(i-1);
end
% ��ͼ
ROIXAxis = 1 : ROIcol;
ROIYAxis = 1 : ROIrow;
figure;
bar(ROIXAxis, ROIXProject);
title('ROI��x��ֱ��ͼ');
figure;
bar(ROIYAxis, ROIYProject);
title('ROI��y��ֱ��ͼ');
% �ֿ�
XStep = floor(ROIcol / 10);%x��ÿ��Ĵ�С
YStep = floor(ROIrow / 10);%y��ÿ��Ĵ�С
%��ʼ��xy��ÿһ���ֵ
XBlock = zeros(1, 10);
YBlock = zeros(1, 10);
for i = 1 : 10
    if i == 1
        XBlock(1) = ROIXProjectSum(XStep * i);
        YBlock(1) = ROIYProjectSum(YStep * i);
        continue;
    end
    if i == 10
        XBlock(10) = ROIXProjectSum(ROIcol) - ROIXProjectSum(XStep * 9);
        YBlock(10) = ROIYProjectSum(ROIrow) - ROIYProjectSum(YStep * 9);
        break;
    end
    XBlock(i) = ROIXProjectSum(XStep * i) - ROIXProjectSum(XStep * (i - 1));%����x��ÿһ���ֵ
    YBlock(i) = ROIYProjectSum(YStep * i) - ROIYProjectSum(YStep * (i - 1));%����y��ÿһ���ֵ
end
% ��ͼ
ROIXAxis = 1 : 10;
ROIYAxis = 1 : 10;
figure;
bar(ROIXAxis, XBlock);
title('ROI�ֿ���x��ֱ��ͼ');
figure;
bar(ROIYAxis, YBlock);
title('ROI�ֿ���y��ֱ��ͼ');
% ȷ�����յ��и��
[ROIXMax, ROIXPlace] = max(XBlock);%ȷ���и�λ�õ�x������
i = 10;%��ʼ��i
if YBlock(10) == ROIcol * (ROIrow - 9 * YStep)
    for i = 9 : -1 : 1
        if YBlock(i) ~= ROIcol * YStep
            break;
        end
    end
end
ROIYPlace = i - 1;
% ��ROI���д���

% ת����ԭ�����²���ͼ
XPlaceL = (ROIXPlace - 1) * XStep + RecLDown(2) - 1;
XPlaceR = ROIXPlace * XStep + RecLDown(2) - 1;
YPlaceU = (ROIYPlace - 1) * YStep + RecLUp(1) - 1;
YPlaceD = ROIYPlace * YStep + RecLUp(1) - 1;
FinalImg = bw;
FinalImg(YPlaceU : YPlaceD, XPlaceL : XPlaceR) = 0;
figure;
imshow(FinalImg);
figure;
Finalrgbimg = rgbimg;
Finalrgbimg(YPlaceU : YPlaceD, XPlaceL : XPlaceR, 1) = 256;
Finalrgbimg(YPlaceU : YPlaceD, XPlaceL : XPlaceR, 2 : 3) = 1;
imshow(Finalrgbimg);
% ת����ԭ�����²���ͼ

% ��ʾȥ���������ԭͼ
% bww=im2uint8(bw)/255;
% rgbimg(:, :, 1)=bww.*rgbimg(:, :, 1);
% rgbimg(:, :, 2)=bww.*rgbimg(:, :, 2);
% rgbimg(:, :, 3)=bww.*rgbimg(:, :, 3);
% figure;
% imshow(rgbimg);