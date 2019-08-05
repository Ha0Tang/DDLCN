clear all;close all;clc

address1 = './step2_dictionary_trainning/first_dic';
address2 = './two_layers_coding/step3_firstlayer_coding';

content1 = dir(address1);

cd(address1);

dic1_groupsize30_rand30_mex = [];

for i = 3:length(content1)
    load(content1(i).name);
    dic1_groupsize30_rand30_mex = [dic1_groupsize30_rand30_mex, Dic];
end
cd(address2);

a = 'dic1_groupsize30_rand30_mex';

save(a, 'dic1_groupsize30_rand30_mex');