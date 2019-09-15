
clear all;close all;clc
address1 = './step3_firstlayer_coding/first_layer_coding';

content1 = dir(address1);
address2 = './step5_secondlayer_coding/second_layer_coding';
content2 = dir(address2);

content3 = dir('./step1_sift_extract/sift_feature/caltech101');
address3 = './step1_sift_extract/sift_feature/caltech101';

address5 = './step6_pyramid_coding';

address6 = './step6_pyramid_coding/concatenate';
if ~isdir(address6)
    mkdir(address6);
end
%i = 3;
%j = 3;
for i = 3:length(content1)
    
cd(address6)
mkdir(content1(i).name);

cd(address1);
sub_contents = dir(content1(i).name);

for j = 3:length(sub_contents)

cd(content1(i).name);
load(sub_contents(j).name);%codes

cd(address2)
cd(content1(i).name);
load(sub_contents(j).name);%codes_corresponding_second_layer_code

cd(address3);
cd(content1(i).name);
load(sub_contents(j).name);%feaSet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

code_concatenate = [codes;codes_corresponding_second_layer_code];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd(address5)
coef_concatenate_pyramid = pyramid_coding(code_concatenate, codes, codes_corresponding_second_layer_code, feaSet);%����dic_groupsize15_rand15��Ϊ��ȷ���ֵ������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd(address6)
cd(content1(i).name);

save(sub_contents(j).name,'coef_concatenate_pyramid');

cd(address1)
end

end
cd(address6)




