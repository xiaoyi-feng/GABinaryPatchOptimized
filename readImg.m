% 将某一文件夹下的所有bmp图像进行读取并放入到同一个图像数组中
function [imgs]= readImg(img_dir)

    img_files = dir(fullfile(img_dir,'*.bmp')); % fullfile()路径的拼接
    len = size(img_files,1);
%     imgs = zeros(2048,2448,len,1);
    imgs = zeros(1140,912,len);
    for j = 1: len          %  18步相移==18幅相移条纹
        fileName = strcat(img_dir,img_files(j).name);
        image = imread(fileName);
        imgs(:,:,j) = image;        % 第四个1表示的是条纹的频率数，这里是空间相位展开所以只有一种条纹呢频率
    end

end