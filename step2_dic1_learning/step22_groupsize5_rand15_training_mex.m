clear all; close all;clc

param.K = 4; %the number of dictionary elements to train
param.lambda = 0.35;
param.numThreads = 4;
param.iter = 500;
param.mode = 0;

address0='./step2_dictionary_trainning/first_dic';
address1 = './step2_dictionary_trainning';
address2 = './step2_dictionary_trainning/rand_sect';

if ~isdir(address0)
    mkdir(address0);
end


contents = dir(address2);
cd(address2);
for i = 3:length(contents)
load(contents(i).name);
    cd(address1);
    
    X = selected_data;
    
    Dic = mexTrainDL(X,param);
    
    cd(address0);
    a = contents(i).name;
    save(a,'Dic');
    cd(address2);
end
cd(address1);
