%%%
% �� ����뷽ʽ��һά��ֵ����
% ���ɳ���һ����ֻ��0,1�������ֵ����
%%%
classdef Individual
    properties  % �����������
        Indi_code = [];
        Length ;
        Fitness;
        Ei;
        Ep;
        T;
    end
    methods    % ������ķ���
        
        function individual = Individual( length,t)      % ��Ĺ��췽��
%             individual.Indi_code = indi_code;
            individual.Length = length;
            individual.T = t;   % ָ������������
        end
        
        function obj = initialize(obj)
            length = obj.Length;
%             binary_array = round(rand(1,length)); % rand()����0-1�ڵ������
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
        
        % �ɸ���ı�����Ϣ����ø������Ӧ��
        function fitness = calculate_fitness(obj)
            addpath(genpath('E:\fxy\GABinaryPatchOpti\')); 
            indi_code = obj.Indi_code;
            sx = obj.T/2;
            sy = obj.Length/sx;
            indi_code =reshape( indi_code',[sx sy])';

            % ����ǿ�����:ֱ�Ӻ���������ǿ�����Ա�
            freq = 10;
            rows = 120;
            cols = obj.T*freq; 


            step = 3;
%             filter_size = 5;
            fringes = generateVerticalFringes(rows, cols, freq,step);        % ����3����������
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


            % ��������һά����֮������
            obj.Ei =  sqrt(sum(sum((gaussi_img(10:109 ,10:109,1)*255 - fringes(10:109, 10:109,1)).^2))/(100*100));
            fitness = obj.Ei;    %  �Ż�Ŀ�꺯����ֻ���� ǿ�����뽹��Ҳ��ֻ��һ�� ��5 * 5�ĸ�˹����
%             binary_phase1 = NStepPhaseShift( gaussi_img1);
%             binary_phase2 = NStepPhaseShift( gaussi_img2);
%             binary_phase3 = NStepPhaseShift( gaussi_img3);
%             sin_phase = NStepPhaseShift(fringes);
%             obj.Ep = sqrt(sum(sum((binary_phase1(10:99,10:99)-sin_phase(10:99,10:99)).^2))/(90*90));
%             fitness = obj.Ep;    %  �Ż�Ŀ��ֻ����λ���

%             error1 = sqrt(sum(sum((binary_phase1(10:99 ,10:99) - sin_phase(10:99 ,10:99)).^2))/( 90*90)); 
%             error2 = sqrt(sum(sum((binary_phase2(10:99 ,10:99) - sin_phase(10:99 ,10:99)).^2))/( 90*90));
%             error3 = sqrt(sum(sum((binary_phase3(10:99 ,10:99) - sin_phase(10:99 ,10:99)).^2))/( 90*90));
%             obj.Ep = 1/3 * error1 + 1/3 * error2 + 1/3 * error3;
%             fitness = obj.Ep;
%             obj.Ep = sqrt(sum(sum((binary_phase(10:99 ,10:99) - sin_phase(10:99 ,10:99)).^2))/( 90*90)); % [sy-2,sx-2]
%             fitness = 0.7/(2* pi) * obj.Ep + 0.3/(2 * max(max(fringes(:,:,1)))) * obj.Ei;      % ����ø������Ӧ�ȣ����ۺϿ���ǿ��������λ��� 

        end
        
        function obj = mutate(obj , rate)      % ����ı������ֻ����ֵ�ĸı䣬����ɾ�������У���Ϊ��ı���屾��ı��볤��
            random1 = rand(1);           % �������0-1�ڵ�����
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
            gaussi_binarycode_i =  Gaussi(indi_code * 255,sy,obj.T);  %  ���ص���һ����ά����
            % ����ǿ�����:ֱ�Ӻ���������ǿ�����Ա�
            freq = 10;
            step = 3;
            rows = obj.T * freq;
            cols = obj.T * freq;
           
            fringes = generateVerticalFringes(rows, cols, freq,step);        % ����3����������
            sin_i = fringes(1:  sy , obj.T+1: obj.T+sx,1);
            intensity_diff_all = gaussi_binarycode_i(:,:)-sin_i(:,:);
            intensity_diff_center = intensity_diff_all(round(sy/2)-1 : round(sy/2)+1 ,3:sx-2); % ������ıȽϵ������� ���ĵ� 3*(sx-4)
          
            intensity_diff = reshape(intensity_diff_center,[],1)';  % ����ά����ת���ɶ�Ӧ�� һά����
          
            [ val ,~] = max(abs(intensity_diff));  % ���������һ��������ͻ��ļ��ʸ���������һ�鷢��ͻ������ǵ�����ͻ��
            random2 = rand(1);
            index = find(intensity_diff_all==val);
            if random2 < 0.5
                % mutate
                if index <= 2
                    obj.Indi_code(index : index +4) = 1- obj.Indi_code(index: index +4); 
                elseif index > obj.Length - 2
                    obj.Indi_code(index-4 : index ) = 1- obj.Indi_code(index - 4: index ); 
                else
                    obj.Indi_code(index-2 : index +2) = 1- obj.Indi_code(index - 2: index + 2);      % 0 ��Ϊ 1 ��1 ��Ϊ 0
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