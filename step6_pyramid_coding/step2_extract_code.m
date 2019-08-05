tic
clear;
clc;
contents = dir('./step6_pyramid_coding/concatenate');
cd('./step6_pyramid_coding/concatenate');
code_final = [];
label_final = [];
for i = 3:length(contents)
sub = dir(contents(i).name);
cd(contents(i).name);
code = [];
label = [];
    for j = 3:length(sub)
    load(sub(j).name);
    code = [code, coef_concatenate_pyramid];
    end
label = (i-2)*ones(1,length(sub)-2);
code_final = [code_final,code];
label_final = [label_final,label];
cd('..');
end
cd('..');
save('final_500_500_mnist','-v7.3');

