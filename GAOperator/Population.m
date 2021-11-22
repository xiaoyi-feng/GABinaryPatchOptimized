classdef Population
    properties
        Pop_size;
        Indi_len;
        Individuals(1,120);
        T;
    end
    
    methods
        function population = Population(pop_size, indi_len,t)
            population.Pop_size = pop_size;       
            population.Indi_len = indi_len;
            population.T = t;
            population.Individuals = Individual(population.Indi_len,t);
        end
        
        function obj = initialize(obj)
            addpath(genpath('E:\fxy\GABinaryPatchOpti\')); % ������Ŀ·�������������ļ������Ϊ����·��
%             rows = 256;
%             cols = 256;
            freq = 10;    % �������� = 48���أ�Ƶ�� = 5
            step = 3;
            rows = obj.T * freq;
            cols = obj.T * freq;
            sx = obj.T /2; 
            sy = obj.Indi_len / sx;
           
            fringes = generateVerticalFringes(rows, cols, freq,step);
%             sin_in = fringes(10:9 + sy ,obj.T + 1 : obj.T + sx );
%             x = 1:1:19;
%             plot(x,sin_in);
            % ���������ɢ�������������ƽ��ж�ֵ��
            binary_img1 = FloydErrorDiffusion(fringes, 7,3,5,1,16,rows,cols,step);    % double���͵�
            img1 = binary_img1(:,:,1);
%             b1 =  img1(10:9 + sy ,obj.T + 1 : obj.T + sx )';
%             b1 = uint8(reshape((b1/255 ),[],1)');
            individual_1 = Individual(obj.Indi_len,obj.T);
            individual_2 = Individual(obj.Indi_len,obj.T);
            individual_3 = Individual(obj.Indi_len,obj.T);
            individual_4 = Individual(obj.Indi_len,obj.T);
            individual_1.Indi_code  = uint8(reshape((img1(10:9 + sy ,obj.T + 1 : obj.T + sx  )/255)',[],1)');  

            binary_img2 = FloydErrorDiffusion(fringes, 29,10,17,2,58,rows,cols,step);    % double���͵�
            img2 = binary_img2(:,:,1);
            individual_2.Indi_code = uint8(reshape((img2(10:9 + sy ,obj.T + 1 : obj.T + sx  )/255)',[],1)');
            
            binary_img3 = BayerDithering(fringes(:,:,1));
            individual_3.Indi_code = uint8(reshape((binary_img3(10:9 + sy ,obj.T + 1 : obj.T + sx  )/255)',[],1)');
            
            binary_img4 = FloydErrorDiffusion(fringes, 11,5,7,1,24,rows,cols,step);
            img4 = binary_img4(:,:,1);
            individual_4.Indi_code = uint8(reshape((img4(10:9 + sy ,obj.T + 1 : obj.T + sx  )/255)',[],1)');
%             individual_3.Indi_code = uint8(img(240, 1:24)/255);
%             individual_4.Indi_code = uint8(img(240, 240-23 : 240)/255);
%             plot (x, individual_1.Indi_code, x, individual_2.Indi_code, x, individual_3.Indi_code,x, individual_4.Indi_code);
            obj.Individuals(1) = individual_1;
            obj.Individuals(2) = individual_2;
            obj.Individuals(3) = individual_3;
            obj.Individuals(4) = individual_4;
            for i = 5: +1 : obj.Pop_size
                individual = Individual(obj.Indi_len,obj.T);
                individual = individual.initialize();
                obj.Individuals(i) = individual; %����һ�������Ȼ��Ըö����е����Խ��и�ֵ���ͻ��Զ�����set��������ȡ���Ծͻ��Զ�����get���� ��
            end       
        end
%         
        function obj = calculate_pop_fitness(obj)
            for i =1: 1:60
                % ���ü��������Ӧ�Ⱥ�����������Ⱥ��ÿ���������Ӧ��
                obj.Individuals(i).Fitness = obj.Individuals(i).calculate_fitness();   
            end
        end
        
        function indi_info = get_individual_at(obj,i)
            indi_info =  obj.Individuals(i);
        end
        function pop_size = get.Pop_size(obj)
            pop_size = obj.Pop_size;
        end

                
    end
 end
