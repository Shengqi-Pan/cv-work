clc;
I=imread('test.png');%ͼƬ����
bw=im2bw(I);         %��ͼ���ֵ��
[r,c]=find(bw==0);  
[rectx,recty,area,perimeter] = minboundrect(c,r,'a'); %'a'�ǰ���������С���Σ�������߳���'p'��
figure
imshow(bw);
line(rectx(:),recty(:),'color','r');
