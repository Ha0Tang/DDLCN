clc;
clear;
tic
Number_1_layer_nonzeors = 15;
number_of_atom = 11;

param.L=number_of_atom-1;
param.lambda=0.15;
param.mode=2;
param.numThreads=8;

address_base = './step5_secondlayer_coding';

load('./step4_dic2_trainning/method2_dic2_rand30_groupsize30_mex');

Dic = Dic_SPAMS;

load('./step3_firstlayer_coding/dic1_groupsize30_rand30_mex');

dic_groupsize20_rand30_mex = dic1_groupsize30_rand30_mex;

address1 = './step3_firstlayer_coding/first_layer_coding';
address2 = './step5_secondlayer_coding/second_layer_coding';
if ~isdir(address2)
    mkdir(address2);
end

contents = dir(address1);

cd(address1);

for j = 3:length(contents)
    sub_contents = dir(contents(j).name);
    cd(address2);
    mkdir(contents(j).name);
    
    cd(address1);
    cd(contents(j).name);
    
    for i = 3:length(sub_contents)
        load(sub_contents(i).name);

      
        ind_length = Number_1_layer_nonzeors;%15
        
        cd(address2);
        codes_corresponding_second_layer_code = [];
        for index = 1:size(codes,2)
            ind = find(codes(:,index));
            
            v_group = dic_groupsize20_rand30_mex(:,ind);
            if size(v_group,2) ~= ind_length
                
                v_group = dic_groupsize20_rand30_mex(:,1:ind_length);
                ind = [1:ind_length];
            end
                   
            W = 0.01*ones(size(Dic,2),size(v_group,2));
            for index_v_group = 1:size(v_group,2)
                temple1 = repmat(v_group(:,index_v_group), [1, size(Dic,2)]);
                e = (temple1 - Dic).^2;
     
                norm_compare = zeros(1,size(Dic,2));
                
                    for jj = 1:size(Dic,2)
                        norm_compare(1,jj) = norm(e(:,jj),2);
                    end
                
                sort_temple1 = sort(norm_compare);
                sort_temple2 = find(norm_compare<sort_temple1(number_of_atom));
                norm_compare = 10./norm_compare;
                temple3 = 0.01*ones(1,size(norm_compare,2));
                temple3(1,sort_temple2) = norm_compare(1,sort_temple2);
        
                W(:,index_v_group) = temple3';
            end
            
            second_layer_codes = mexLassoWeighted(v_group, Dic, W, param);
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

           codes_indexth_column = codes(:,index);
           codes_temple1 = codes_indexth_column(ind);
           codes_temple2 = diag(codes_temple1);
           
           if norm(codes_temple1) == 0
               codes_temple2 = diag(ones(1,ind_length));
           end
           
           if length(codes_temple1) ~= ind_length
               codes_temple2 = diag([codes_temple1; ones((ind_length-length(codes_temple1)),1) ]);
           end
               
           second_layer_codes = second_layer_codes*codes_temple2;
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           
        codes_corresponding_second_layer_code = [codes_corresponding_second_layer_code, reshape(second_layer_codes,[],1)];
        clear W;
        clear second_layer_codes;
        
        cd(address1);
        
        cd(contents(j).name);
        end
        
        cd(address2);
        cd(contents(j).name);
        save(sub_contents(i).name, 'codes_corresponding_second_layer_code');
        clear codes_corresponding_second_layer_code;
        cd(address1);
        cd(contents(j).name);
    end
    cd(address1)
end




