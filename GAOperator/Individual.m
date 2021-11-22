%%%
% 个 体编码方式：一维二值数组
% 生成长度一定的只含0,1的随机二值数组
%%%
classdef Individual
    properties  % 定义类的属性
        Indi_code = [];
        Length ;
        Fitness;
        Ei;
        Ep;
        T;
    end
    methods    % 定义类的方法
        
        function individual = Individual( length,t)      % 类的构造方法
%             individual.Indi_code = indi_code;
            individual.Length = length;
            individual.T = t;   % 指的是条纹周期
        end
        
        function obj = initialize(obj)
            length = obj.Length;
%             binary_array = round(rand(1,length)); % rand()生成0-1内的随机数
            for i=1 :length
                random_num  = rand(1);
                if random_num > 0.5
                    binary_array(i) = 1;
                else
                    binary_array(i) = 0;
                end
            end
            obj.Indi_code = binary_array;
        end
        
        % 由个体的编码信息计算该个体的适应度
        function fitness = calculate_fitness(obj)
            addpath(genpath('E:\fxy\GABinaryPatchOpti\')); 
            indi_code = obj.Indi_code;
            sx = obj.T/2;
            sy = obj.Length/sx;
            indi_code =reshape( indi_code',[sx sy])';

            % 计算强度误差:直接和正弦条纹强度作对比
            freq = 10;
            rows = 120;
            cols = obj.T*freq; 


            step = 3;
%             filter_size = 5;
            fringes = generateVerticalFringes(rows, cols, freq,step);        % 生成3步正弦条纹
            fringes = fringes(:,1:120,:);    % 120 *120
            binary_pattern = GenerateBinaryPattern(indi_code, obj.T, 120, 120,step);
%             w = fspecial('gaussian',[filter_size  filter_size ],filter_size/3);
%             gaussi_img = imfilter(binary_pattern,w,'replicate');
            filter_size = [5, 9, 13];
            w1 = fspecial('gaussian', [filter_size(1) filter_size(1)],filter_size(1)/3);
%             w2 = fspecial('gaussian', [filter_size(2) filter_size(2)],filter_size(2)/3);
%             w3 = fspecial('gaussian', [filter_size(3) filter_size(3)],filter_size(3)/3);
            gaussi_img = imfilter(binary_pattern,w1,'replicate');
%             gaussi_img2 = imfilter(binary_pattern,w2,'replicate');
%             gaussi_img3 = imfilter(binary_pattern,w3,'replicate');
            gaussian_1 = gaussi_img(:,:,1);
            sin_1 = fringes(:,:,1);


            % 计算两个一维数组之间的误差
            obj.Ei =  sqrt(sum(sum((gaussi_img(10:109 ,10:109,1)*255 - fringes(10:109, 10:109,1)).^2))/(100*100));
            fitness = obj.Ei;    %  优化目标函数中只包含 强度误差，离焦量也是只有一个 即5 * 5的高斯窗口
%             binary_phase1 = NStepPhaseShift( gaussi_img1);
%             binary_phase2 = NStepPhaseShift( gaussi_img2);
%             binary_phase3 = NStepPhaseShift( gaussi_img3);
%             sin_phase = NStepPhaseShift(fringes);
%             obj.Ep = sqrt(sum(sum((binary_phase1(10:99,10:99)-sin_phase(10:99,10:99)).^2))/(90*90));
%             fitness = obj.Ep;    %  优化目标只含相位误差

%             error1 = sqrt(sum(sum((binary_phase1(10:99 ,10:99) - sin_phase(10:99 ,10:99)).^2))/( 90*90)); 
%             error2 = sqrt(sum(sum((binary_phase2(10:99 ,10:99) - sin_phase(10:99 ,10:99)).^2))/( 90*90));
%             error3 = sqrt(sum(sum((binary_phase3(10:99 ,10:99) - sin_phase(10:99 ,10:99)).^2))/( 90*90));
%             obj.Ep = 1/3 * error1 + 1/3 * error2 + 1/3 * error3;
%             fitness = obj.Ep;
%             obj.Ep = sqrt(sum(sum((binary_phase(10:99 ,10:99) - sin_phase(10:99 ,10:99)).^2))/( 90*90)); % [sy-2,sx-2]
%             fitness = 0.7/(2* pi) * obj.Ep + 0.3/(2 * max(max(fringes(:,:,1)))) * obj.Ei;      % 计算该个体的适应度，即综合考虑强度误差和相位误差 

        end
        
        function obj = mutate(obj , rate)      % 个体的变异操作只能是值的改变，增加删除都不行，因为会改变个体本身的编码长度
            random1 = rand(1);           % 随机生成0-1内的数字
            addpath(genpath('E:\fxy\GABinaryPatchOpti\'));
            a = 1;
            b = obj.Length;
            sx = obj.T/2;
            indi_code = obj.Indi_code;
            mutate_points = round(b/sx);
            sy = obj.Length/sx;
            if random1<rate
               mutate_index = round( a +(b-a)*rand(1,mutate_points));
               for i = 1: mutate_points
                   obj.Indi_code(mutate_index(i)) = 1 - obj.Indi_code(mutate_index(i));
               end
            end
%             a= 1;  
            gaussi_binarycode_i =  Gaussi(indi_code * 255,sy,obj.T);  %  返回的是一个二维数组
            % 计算强度误差:直接和正弦条纹强度作对比
            freq = 10;
            step = 3;
            rows = obj.T * freq;
            cols = obj.T * freq;
           
            fringes = generateVerticalFringes(rows, cols, freq,step);        % 生成3步正弦条纹
            sin_i = fringes(1:  sy , obj.T+1: obj.T+sx,1);
            intensity_diff_all = gaussi_binarycode_i(:,:)-sin_i(:,:);
            intensity_diff_center = intensity_diff_all(round(sy/2)-1 : round(sy/2)+1 ,3:sx-2); % 有意义的比较的区域是 中心的 3*(sx-4)
          
            intensity_diff = reshape(intensity_diff_center,[],1)';  % 将二维数组转换成对应的 一维数组
          
            [ val ,~] = max(abs(intensity_diff));  % 误差最大的那一块区域发生突变的几率更大，是整个一块发生突变而不是单个点突变
            random2 = rand(1);
            index = find(intensity_diff_all==val);
            if random2 < 0.5
                % mutate
                if index <= 2
                    obj.Indi_code(index : index +4) = 1- obj.Indi_code(index: index +4); 
                elseif index > obj.Length - 2
                    obj.Indi_code(index-4 : index ) = 1- obj.Indi_code(index - 4: index ); 
                else
                    obj.Indi_code(index-2 : index +2) = 1- obj.Indi_code(index - 2: index + 2);      % 0 变为 1 ；1 变为 0
                end
            end
        end
   
        
        function obj = set.Fitness(obj,fitness)
            obj.Fitness = fitness;
        end
        
        function fitness = get.Fitness(obj)
            fitness = obj.Fitness;
        end
        function obj = set.Indi_code(obj,binary_code)
            obj.Indi_code = binary_code;
        end
        
        function length = get.Length(obj)
            length = obj.Length;
        end
        
        function indi_code = get.Indi_code(obj)
            indi_code = obj.Indi_code;
        end
        
        function obj = set.Ei(obj,ei)
            obj.Ei = ei;
        end
       
        function ei = get.Ei(obj)
            ei = obj.Ei;
        end
        function obj = set.Ep(obj,ep)
            obj.Ep = ep;
        end
       
        function ei = get.Ep(obj)
            ei = obj.Ep;
        end
        
    end
end