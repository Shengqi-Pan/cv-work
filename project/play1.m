clc;
clear;
close all;

% 初始化
rgbimg = imread('test3.jpg');
% figure;
imshow(rgbimg);
r = rgbimg(:, :, 1);
g = rgbimg(:, :, 2);
b = rgbimg(:, :, 3);

grayimg = rgb2gray(rgbimg);
[row, col] = size(grayimg);%行数和列数

hsvimg = rgb2hsv(rgbimg);
H = hsvimg(:, :, 1);
S = hsvimg(:, :, 2);
V = hsvimg(:, :, 3);
% 初始化

I = H;%提取H色彩空间
% hy = fspecial('sobel');%sobel算子
% hx = hy';
% Iy = imfilter(double(I), hy, 'replicate');%滤波求y方向边缘
% Ix = imfilter(double(I), hx, 'replicate');%滤波求x方向边缘
% gradmag = sqrt(Ix.^2 + Iy.^2);%求摸

% 阈值分割
% 分别对前景和背景进行标记：使用形态学重建技术对前景对象进行标记，首先使用开操作，开操作之后可以去掉一些很小的目标。
se = strel('disk', 40);%圆形结构元素
% 腐蚀
Io = imopen(I, se);%形态学开操作
Ie = imerode(I, se);%对图像进行腐蚀
Iobr = imreconstruct(Ie, I);%形态学重建
% 膨胀
Ioc = imclose(Io, se);%形态学关操作
Iobrd = imdilate(Iobr, se);%对图像进行膨胀
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));%形态学重建
Iobrcbr = imcomplement(Iobrcbr);%图像求反
bw = imbinarize(Iobrcbr, graythresh(Iobrcbr));%转化为二值图像
bw = imcomplement(bw);%图像求反
% figure;
imshow(bw) %显示二值图像
title('Thresholded opening-closing by reconstruction')
% 阈值分割

% 求重心
XProject = sum(bw);%二值图在x轴的投影
YProject = sum(bw, 2);%二值图在y轴的投影
XProjectSum = XProject;
YProjectSum = YProject;
for i = 2 : col
    XProjectSum(i) = XProjectSum(i) + XProjectSum(i-1);
end
for i = 2 : row
    YProjectSum(i) = YProjectSum(i) + YProjectSum(i-1);
end
%画图
XAxis = 1 : col;
YAxis = 1 : row;
figure;
bar(XAxis, XProjectSum);
title('x轴累积直方图');
figure;
bar(YAxis, YProjectSum);
title('y轴累积直方图');
% 分别求x轴y轴重心
XHalf = sum(XProject)/2;%求x轴一半
YHalf = sum(YProject)/2;%求y轴一半
for i = 2 : col
    if XHalf > XProjectSum(i-1) && XHalf < XProjectSum(i)
        break;
    end
end
XCenter = i;%x轴中心
for i = 2 : row
    if YHalf > YProjectSum(i-1) && YHalf < YProjectSum(i)
        break;
    end
end
YCenter = i;%y轴中心
bwCenter = bw;
bwCenter(YCenter - 5 : YCenter + 5, XCenter - 5 : XCenter + 5) = 0;
figure;
imshow(bwCenter);
% 求重心

% 求半径
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
% 求半径

% 根据半径框出ROI
RecLDown = [floor(YCenter - R / 2), floor(XCenter - R / 2)];%矩形左下角的点为RecLDown
RecRDown = [floor(YCenter - R / 2), floor(XCenter + R / 2)];%矩形右下角的点为RecRDown
RecLUp = [max(1, floor(YCenter - R / 2 - R)), floor(XCenter - R / 2)];%矩形左上角的点为RECLUp
RecRUp = [max(1, floor(YCenter - R / 2 - R)), floor(XCenter + R / 2)];%矩形右上角的点为RecRUp
ROI = bw(RecLUp(1) : RecRDown(1), RecLDown(2) : RecRUp(2));
figure;
imshow(ROI);
% 根据半径框出ROI

% 对ROI进行处理
[ROIrow, ROIcol] = size(ROI);
ROIXProject = sum(ROI);%二值图在x轴的投影
ROIYProject = sum(ROI, 2);%二值图在y轴的投影
ROIXProjectSum = ROIXProject;
ROIYProjectSum = ROIYProject;
for i = 2 : ROIcol
    ROIXProjectSum(i) = ROIXProjectSum(i) + ROIXProjectSum(i-1);
end
for i = 2 : ROIrow
    ROIYProjectSum(i) = ROIYProjectSum(i) + ROIYProjectSum(i-1);
end
% 画图
ROIXAxis = 1 : ROIcol;
ROIYAxis = 1 : ROIrow;
figure;
bar(ROIXAxis, ROIXProject);
title('ROI的x轴直方图');
figure;
bar(ROIYAxis, ROIYProject);
title('ROI的y轴直方图');
% 分块
XStep = floor(ROIcol / 10);%x轴每块的大小
YStep = floor(ROIrow / 10);%y轴每块的大小
%初始化xy轴每一块的值
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
    XBlock(i) = ROIXProjectSum(XStep * i) - ROIXProjectSum(XStep * (i - 1));%计算x轴每一块的值
    YBlock(i) = ROIYProjectSum(YStep * i) - ROIYProjectSum(YStep * (i - 1));%计算y轴每一块的值
end
% 画图
ROIXAxis = 1 : 10;
ROIYAxis = 1 : 10;
figure;
bar(ROIXAxis, XBlock);
title('ROI分块后的x轴直方图');
figure;
bar(ROIYAxis, YBlock);
title('ROI分块后的y轴直方图');
% 确定最终的切割点
[ROIXMax, ROIXPlace] = max(XBlock);%确定切割位置的x轴坐标
i = 10;%初始化i
if YBlock(10) == ROIcol * (ROIrow - 9 * YStep)
    for i = 9 : -1 : 1
        if YBlock(i) ~= ROIcol * YStep
            break;
        end
    end
end
ROIYPlace = i - 1;
% 对ROI进行处理

% 转换到原坐标下并作图
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
% 转换到原坐标下并作图

% 显示去除背景后的原图
% bww=im2uint8(bw)/255;
% rgbimg(:, :, 1)=bww.*rgbimg(:, :, 1);
% rgbimg(:, :, 2)=bww.*rgbimg(:, :, 2);
% rgbimg(:, :, 3)=bww.*rgbimg(:, :, 3);
% figure;
% imshow(rgbimg);