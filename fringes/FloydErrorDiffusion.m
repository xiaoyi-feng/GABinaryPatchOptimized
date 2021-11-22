
function  binary_img = FloydErrorDiffusion(fringes,alpha1,alpha2,alpha3,alpha4,alpha_sum,rows,cols,step)
binary_img = zeros(rows,cols,step);
for i = 1 : step  % �Ĳ�����
    [M,N] = size(fringes(:,:,1));
    binary_img(:,:,i)= fringes(:,:,i);
    threshold = 128;
    % scan����ɨ�裬�����ң����ϵ���
    for row = 1 : 1 : M
        for column = 1: 1 :N
            if binary_img(row,column,i) > threshold
                error = binary_img(row,column,i) - 255; % �������= ԭʼ�Ҷȼ�����ɢ���֮��ĻҶ� - ��ֵ��֮��ĻҶ�ֵ
                binary_img(row,column,i) = 255;
            else
                error = binary_img( row,column,i) - 0;
                binary_img(row,column,i) = 0;
            end
            
            if column == 1 && row <M % ��߽��ȥ���һ�м���ȥ���½�
                binary_img( row,column+1 ,i) =  binary_img( row,column+1 ,i) + error *alpha1/alpha_sum;
                binary_img( row + 1,column ,i ) =  binary_img( row + 1,column ,i) + error *alpha3/alpha_sum;
                binary_img(row + 1,column+1 , i) =  binary_img(row + 1,column+1 ,i) + error *alpha4/alpha_sum;
            elseif column == N && row <M     % �ұ߽��ȥ���½�
                binary_img( row+1,column ,i) =  binary_img( row+1,column ,i) + error *alpha3/alpha_sum;
                binary_img( row + 1,column-1 ,i) =  binary_img( row+1,column-1 ,i) + error *alpha2/alpha_sum;
            elseif column <N && row == M         % �±߽��ȥ���½�
                binary_img( row,column+1 ,i) =  binary_img( row,column+1 ,i) + error *alpha1/alpha_sum;
            elseif column == N && row == 1            % ���Ͻ�
                binary_img( row+1,column ,i) =  binary_img( row+1,column , i) + error *alpha3/alpha_sum;
                binary_img( row+1,column-1 ,i) =  binary_img( row+1,column-1 ,i) + error *alpha2/alpha_sum;
            elseif column == N && row == M              % ���½�
                
            else
                binary_img(row,column+1 , i) =  binary_img(row,column+1 ,i) + error *alpha1/alpha_sum;
                binary_img( row +1,column  ,i) =  binary_img( row +1,column , i) + error *alpha3/alpha_sum;
                binary_img(row +1,column-1 , i) =  binary_img(row +1,column-1 ,i) + error *alpha2/alpha_sum;
                binary_img(row+1,column+1 , i) =  binary_img(row+1,column+1 ,i) + error *alpha4/alpha_sum; 
            end       % if
        end
    end
end

% ��ʾ����Floyd�����ɢ֮��õ��Ľ��
% figure;
% imshow(binary_img(:,:,1));
% title("Floyd Error Diffusion");

end






