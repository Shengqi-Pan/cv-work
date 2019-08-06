%Name: ROI extraction
%Function: Extract ROI in a RGB image
%Author:    Changle Zhang, zhangchanglehit@163.com
clc;
clear all;
close all;
%Initilization
rgbimg = imread('test.jpg');
figure;
imshow(rgbimg);
r = rgbimg(:, :, 1);
g = rgbimg(:, :, 2);
b = rgbimg(:, :, 3);
% imshow(r);
% figure;
% imshow(g);
% figure;
% imshow(b);
% grayimg=rgb2gray(rgbimg);
% imshow(grayimg);
hsvimg = rgb2hsv(rgbimg);
H = hsvimg(:, :, 1);
S = hsvimg(:, :, 2);
V = hsvimg(:, :, 3);
% figure;
% imshow(H);
% title('H');
% figure;
% imshow(S);
% title('S');
% figure;
% imshow(V);
% title('V');



%rgb = imread('pears.png');%��ȡԭͼ��
I = H;%ת��Ϊ�Ҷ�ͼ��
hy = fspecial('sobel');%sobel����
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');%�˲���y�����Ե
Ix = imfilter(double(I), hx, 'replicate');%�˲���x�����Ե
gradmag = sqrt(Ix.^2 + Iy.^2);%����
%3.�ֱ��ǰ���ͱ������б�ǣ�������ʹ����̬ѧ�ؽ�������ǰ��������б�ǣ�����ʹ�ÿ�������������֮�����ȥ��һЩ��С��Ŀ�ꡣ
se = strel('disk', 40);%Բ�νṹԪ��
Io = imopen(I, se);%��̬ѧ������
Ie = imerode(I, se);%��ͼ����и�ʴ
Iobr = imreconstruct(Ie, I);%��̬ѧ�ؽ�
Ioc = imclose(Io, se);%��̬ѧ�ز���
Iobrd = imdilate(Iobr, se);%��ͼ���������
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));%��̬ѧ�ؽ�
Iobrcbr = imcomplement(Iobrcbr);%ͼ����
bw = im2bw(Iobrcbr, graythresh(Iobrcbr));%ת��Ϊ��ֵͼ��
bw = imcomplement(bw);%ͼ����
figure;
imshow(bw), %��ʾ��ֵͼ��
title('Thresholded opening-closing by reconstruction')
bww=im2uint8(bw)/255;
rgbimg(:, :, 1)=bww.*rgbimg(:, :, 1);
rgbimg(:, :, 2)=bww.*rgbimg(:, :, 2);
rgbimg(:, :, 3)=bww.*rgbimg(:, :, 3);
figure;
imshow(rgbimg);
    