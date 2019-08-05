clc;
clear;

number_of_atom = 16;
param.L=number_of_atom-1;
param.lambda=0.15;
param.mode=2;
param.numThreads=8;
load('./step3_firstlayer_coding/dic1_groupsize30_rand30_mex');
dic_groupsize20_rand25_mex = dic1_groupsize30_rand30_mex;
address2 = './step1_sift_extract/sift_feature/mnist';
address3 = './step3_firstlayer_coding/first_layer_coding';
if ~isdir(address3)
    mkdir(address3);
end

contents = dir(address2);

cd(address2);

for j = 3:length(contents)
    sub_contents = dir(contents(j).name);
    cd(address3);
    mkdir(contents(j).name);
    
    cd(address2);
    cd(contents(j).name);
    
    for i = 3:length(sub_contents)
        load(sub_contents(i).name);
        cd(address3);
        W = 0.01*ones(size(dic_groupsize20_rand25_mex,2),size(feaSet.feaArr,2));
        for index = 1:size(feaSet.feaArr,2)    
            temple1 = repmat(feaSet.feaArr(:,index),[1,size(dic_groupsize20_rand25_mex,2)]);
            e = (temple1 - dic_groupsize20_rand25_mex).^2;

            norm_compare = zeros(1,size(dic_groupsize20_rand25_mex,2));
            for jj = 1:size(dic_groupsize20_rand25_mex,2)
                norm_compare(1,jj) = norm(e(:,jj),2);
            end
            sort_temple1 = sort(norm_compare);
            sort_temple2 = find(norm_compare<sort_temple1(number_of_atom));
            norm_compare = 10./norm_compare;
            temple3 = 0.01*ones(1,size(norm_compare,2));
            temple3(1,sort_temple2) = norm_compare(1,sort_temple2);
        
            W(:,index) = temple3';
        end
        codes = mexLassoWeighted(feaSet.feaArr, dic_groupsize20_rand25_mex, W, param);
        clear W;
        cd(address3);
        cd(contents(j).name);
        save(sub_contents(i).name, 'codes');
        clear codes;
        
        cd(address2);
        cd(contents(j).name);
    
    end
    cd(address2);
end