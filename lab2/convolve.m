%%%�������������ĵ�һ������Ϊ����ͼ�񣬵ڶ�������Ϊ�����
%%%���������
%%%����ͼ���Ե����������Ҳ����˵���ͼ����С
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