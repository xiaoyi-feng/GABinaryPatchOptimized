% ��ĳһ�ļ����µ�����bmpͼ����ж�ȡ�����뵽ͬһ��ͼ��������
function [imgs]= readImg(img_dir)

    img_files = dir(fullfile(img_dir,'*.bmp')); % fullfile()·����ƴ��
    len = size(img_files,1);
%     imgs = zeros(2048,2448,len,1);
    imgs = zeros(1140,912,len);
    for j = 1: len          %  18������==18����������
        fileName = strcat(img_dir,img_files(j).name);
        image = imread(fileName);
        imgs(:,:,j) = image;        % ���ĸ�1��ʾ�������Ƶ�Ƶ�����������ǿռ���λչ������ֻ��һ��������Ƶ��
    end

end