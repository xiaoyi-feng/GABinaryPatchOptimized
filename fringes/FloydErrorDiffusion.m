
function  binary_img = FloydErrorDiffusion(fringes,alpha1,alpha2,alpha3,alpha4,alpha_sum,rows,cols,step)
binary_img = zeros(rows,cols,step);
for i = 1 : step  % 四步相移
    [M,N] = size(fringes(:,:,1));
    binary_img(:,:,i)= fringes(:,:,i);
    threshold = 128;
    % scan按行扫描，从左到右，从上到下
    for row = 1 : 1 : M
        for column = 1: 1 :N
            if binary_img(row,column,i) > threshold
                error = binary_img(row,column,i) - 255; % 量化误差= 原始灰度加上扩散误差之后的灰度 - 二值化之后的灰度值
                binary_img(row,column,i) = 255;
            else
                error = binary_img( row,column,i) - 0;
                binary_img(row,column,i) = 0;
            end
            
            if column == 1 && row <M % 左边界除去最后一行即除去左下角
                binary_img( row,column+1 ,i) =  binary_img( row,column+1 ,i) + error *alpha1/alpha_sum;
                binary_img( row + 1,column ,i ) =  binary_img( row + 1,column ,i) + error *alpha3/alpha_sum;
                binary_img(row + 1,column+1 , i) =  binary_img(row + 1,column+1 ,i) + error *alpha4/alpha_sum;
            elseif column == N && row <M     % 右边界除去右下角
                binary_img( row+1,column ,i) =  binary_img( row+1,column ,i) + error *alpha3/alpha_sum;
                binary_img( row + 1,column-1 ,i) =  binary_img( row+1,column-1 ,i) + error *alpha2/alpha_sum;
            elseif column <N && row == M         % 下边界除去右下角
                binary_img( row,column+1 ,i) =  binary_img( row,column+1 ,i) + error *alpha1/alpha_sum;
            elseif column == N && row == 1            % 右上角
                binary_img( row+1,column ,i) =  binary_img( row+1,column , i) + error *alpha3/alpha_sum;
                binary_img( row+1,column-1 ,i) =  binary_img( row+1,column-1 ,i) + error *alpha2/alpha_sum;
            elseif column == N && row == M              % 右下角
                
            else
                binary_img(row,column+1 , i) =  binary_img(row,column+1 ,i) + error *alpha1/alpha_sum;
                binary_img( row +1,column  ,i) =  binary_img( row +1,column , i) + error *alpha3/alpha_sum;
                binary_img(row +1,column-1 , i) =  binary_img(row +1,column-1 ,i) + error *alpha2/alpha_sum;
                binary_img(row+1,column+1 , i) =  binary_img(row+1,column+1 ,i) + error *alpha4/alpha_sum; 
            end       % if
        end
    end
end

% 显示经过Floyd误差扩散之后得到的结果
% figure;
% imshow(binary_img(:,:,1));
% title("Floyd Error Diffusion");

end






