clear all; close all;clc

Number_select = 3;

address1 = './step1_sift_extract/sift_feature/mnist';
address2 = './step2_dic1_trainning/rand_sect';
if ~isdir(address2)
    mkdir(address2)
end
contents = dir(address1);
cd(address1);
len=length(contents);
for j = 3:len
selected_data = [];
sub_contents = dir(contents(j).name);
nLength = length(sub_contents);
index = randperm(nLength-2);

cd(contents(j).name);

    for i = 1:Number_select
        load( sub_contents(index(i)+2).name );
        selected_data = [selected_data, feaSet.feaArr];
    end
    
cd(address2);
a = contents(j).name;
b = '.mat';
ab = strcat(a, b);
save(ab,'selected_data');
clear selected_data;

cd(address1);
end
cd(address2);
cd('..');
