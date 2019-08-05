function [index1, index2] = select_code_label(label_final, nClass, nRandSelectPerClass)

index_train = [];
index_test = [];

Tatle_Length = 0;
for i = 1:nClass
   temple = find(label_final == i);
   nLength = length(temple);
   index = randperm(nLength);
   %index = [index, index+(i-1)*Tatle_Length*ones(1,nLength);
   index = index + (min(temple)-1)*ones(1,nLength);%
   
   index_train = [index_train, index(1:nRandSelectPerClass)];
   index_test = [index_test, index(nRandSelectPerClass+1:nLength)];
   
   Tatle_Length = Tatle_Length + nLength;
    
end
index1 = index_train;
index2 = index_test;


end