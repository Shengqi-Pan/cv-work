%%%%%%%%%%%%
%ֱ��ͼ��ʾ%
%%%%%%%%%%%%
img = imread('test.png');
img = rgb2gray(img);
[row, col] = size(img);%ȷ��ͼ���С
hd = zeros(1,256);
for i = 1 : row
   for j = 1 : col
       k = img(i,j);%����ÿһ�����صĻҶ�ֵ
       hd(k) = hd(k) + 1;%hd(k)��Ӧ�Ҷ�Ϊk�����صĸ���
   end
end
%��ͼ
subplot(2,3,1);
imshow(img);
title('ԭͼ��');
subplot(2,3,2);
grayscale = 1:256;
bar(grayscale, hd);
title('ֱ��ͼ');

%%%%%%%%%%%%%%%%
%�����ۻ�ֱ��ͼ%
%%%%%%%%%%%%%%%%
leiji = hd;
for i = 2 :256
    leiji(i) = leiji(i) + leiji(i-1);
end
%��ͼ
subplot(2,3,3);
bar(grayscale, leiji);
title('�ۻ�ֱ��ͼ');

%%%%%%%%%%%%%%%%%%
%ֱ��ͼ���⻯����%
%%%%%%%%%%%%%%%%%%
bamp = zeros(1,256);
for i=1:256     
    temp=0;     
    for j=1:i         
        temp=temp+hd(j);     
    end
    bmap(i)=floor(temp*255/(row*col));
end
y=zeros(row,col);

for i=1:row    
    for j=1:col         
        y(i,j)=bmap(img(i,j)+1);     
    end
end
y=uint8(y);
subplot(2,3,4);
imshow(y);
title('ֱ��ͼ���⻯������')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%���⻯���ֱ��ͼ%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row, col] = size(y);%ȷ��ͼ���С
hd = zeros(1,256);
for i = 1 : row
   for j = 1 : col
       k = y(i,j);%����ÿһ�����صĻҶ�ֵ
       if k == 0
           k = 1;
       end
       hd(k) = hd(k) + 1;%hd(k)��Ӧ�Ҷ�Ϊk�����صĸ���
   end
end

subplot(2,3,5);
bar(grayscale, hd);
title('���⻯���ֱ��ͼ');

%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������⻯����ۻ�ֱ��ͼ%
%%%%%%%%%%%%%%%%%%%%%%%%%%
leiji = hd;
for i = 2 :256
    leiji(i) = leiji(i) + leiji(i-1);
end
%��ͼ
subplot(2,3,6);
bar(grayscale, leiji);
title('���⻯����ۻ�ֱ��ͼ');