classdef Evolve
    properties
        Population_size;
        Indi_len;
        Gen_no;
        Pop;
        T;
    end
    
    methods
        function evo = Evolve(population_size,indi_len,t)
            evo.Population_size = population_size;
            evo.Indi_len = indi_len;
            evo.T = t;
        end
        
        function obj = initialize_population(obj)
            obj.Gen_no = 0;
            population = Population(obj.Population_size, obj.Indi_len,obj.T);     % 种群大小 = 60
            population = population.initialize();
            population = population.calculate_pop_fitness();     % 现在种群中每个个体的适应度都是已经被计算出来了
            obj.Pop = population;
        end
        
        function obj = recombinate(obj) 
%             print("crossover and mutate...");
            offspring = Population(60,obj.Indi_len,obj.T);
            for i = 1 : obj.Population_size /2
                p1 = obj.tournament_selection();
                p2 = obj.tournament_selection();
%                 while p1.Indi_code == p2.Indi_code
%                     p2 = obj.tournament_selection();
%                 end
                % crossover
                [offset1, offset2] = obj.crossover(p1, p2);
                % mutation
                offset1.mutate(0.2); % 个体突变为了增加种群的多样性
                offset2.mutate(0.2);
                offspring.Individuals(2 * i - 1) = offset1;
                offspring.Individuals(2 * i ) = offset2;
            end
            % 评估子代个体的适应度
            offspring = offspring.calculate_pop_fitness();
            for i = 1 :obj.Population_size
                obj.Pop.Individuals(obj.Population_size +i ) = offspring.Individuals(i);
            end
%             obj.Pop = [obj.Pop , offspring];   % 将父代个体与 子代个体合并
            % 环境选择 
            obj = obj.environment_election();
        end
        
        function  obj = environment_election(obj)
            % obj.Pop :指示的是父代群体, offspring : 是指子代群体
            elite_rate = 0.2;  % 精英个体占比
            assert(length(obj.Pop.Individuals) == 2* obj.Population_size, 'the combinate is error');
            elite_count = round(obj.Population_size * elite_rate);
            % 选取 父代+子代 个体中适应度最高的作为“精英个体”，直接保留下来
            fitness = zeros(1, 2 * obj.Population_size);
            for i = 1: 2* obj.Population_size
                fitness( i )  = obj.Pop.Individuals(i).Fitness;
            end
            [~,index] =sort(fitness); % fitness = all error,所以fitness 值越大，被保留下来的可能性越小;默认升序排列
            elite_list = obj.Pop.Individuals(index(1:elite_count));
            left_list = obj.Pop.Individuals(index(elite_count+1: end));
            left_list = left_list(randperm(length(left_list)));    % 将剩下的个体进行随机打乱
            
            %生成随机数在[1，length(left_list)]范围内的一个随机数
            a=1;
%             b=length(left_list);
            
            % elite_list是保留下来的个体数组
            for i = 1: obj.Population_size - elite_count
                % 每次随机从剩下个体中选择两个，并将他们进行比较从中选择较优的那个个体进入到下一代
                b=length(left_list);
                index1 = round ( a+(b-a)*rand(1));
                index2 = round ( a+(b-a)*rand(1));
                i1 = left_list(index1);
                i2 = left_list(index2 );
                
                opti = obj.selection(i1, i2);
                if isequal(opti.Indi_code(:) ,i1.Indi_code(:))
                    left_list(index1 ) =[];      % 如果该个体已经成功进入到下一代，则从“剩余个体”中剔除，以免重复选到同一个个体进入到下一代
                else
                    left_list(index2) = [];
                end
                elite_list = [elite_list, opti];  
            end
            obj.Pop.Individuals(1:obj.Population_size) = elite_list;
            for i = obj.Population_size +1 : 2 * obj.Population_size
                 obj.Pop.Individuals(i) = Individual(obj.Indi_len,obj.T);
            end     
            obj.Gen_no = obj.Gen_no +1;
        end
        
        function winner = tournament_selection(obj)
            % 从种群中随机抽取两个个体，然后择优winnner
            a = 1;
            b= obj.Population_size;
            indi1_index = round ( a+(b-a)*rand(1));
            indi1 = obj.Pop.Individuals(indi1_index);
            indi2_index = round ( a+(b-a)*rand(1));
%             while (indi1_index == indi2_index)
%                 % 保证随机抽取的2个个体是不同的
%                 indi2_index = round ( a+(b-a)*rand(1));
%             end
            indi2 = obj.Pop.Individuals(indi2_index);
            winner = obj.selection(indi1,indi2);
        end
        
        function opti = selection(obj,indi1 , indi2)
            if indi1.Fitness < indi2.Fitness
                opti = indi1;
            else
                opti = indi2;
            end  
        end
        
        function [offset1, offset2] = crossover(obj, indi1, indi2)
            % 采用的是两点交叉
            offset1 = indi1;
            offset2 = indi2;
            a = 1;
            b = indi1.Length;
            position1 = round ( a+(b-a)*rand(1));
            position2 = round(a + (b-a)* rand(1));
            if position1 > position2
                offset1.Indi_code(position2 : position1) = indi2.Indi_code(position2 : position1);
                offset2.Indi_code(position2 : position1) = indi1.Indi_code(position2 : position1);
            else
                offset1.Indi_code(position1 : position2) = indi2.Indi_code(position1 : position2);
                offset2.Indi_code(position1 : position2) = indi1.Indi_code(position1 : position2);
            end
        end
        
        function gen_no = get.Gen_no(obj)
            gen_no = obj.Gen_no;
        end
        function indi_len = get.Indi_len(obj)
            indi_len = obj.Indi_len;
                end
        function obj = set(obj,indi_len)
            obj.Indi_len = indi_len;
        end
            
    
    end      
end