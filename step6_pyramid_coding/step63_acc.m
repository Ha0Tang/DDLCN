load('./step6_pyramid_coding/final_500_500_mnist.mat');

trainSample=[1,2,3,4,5,10,15,20,25,30];


for i=1:length(trainSample)
tic
   %-----------------------------
   nRandSelectPerClass=trainSample(i);   
   %-----------------------------
   nRunning=10;
   features=code_final;
   label=label_final;
   nClass=101;
    %options = ['-c' num2str(c)];
   acc = zeros(1,nRunning);
    
acc = run_liblinear(nRunning,features,label, nClass, nRandSelectPerClass);

    acc_mean = mean(acc)
    acc_std=std(acc)
    time=toc
       save( ['31-30-' num2str(nRandSelectPerClass)], 'acc', 'acc_mean', 'acc_std', 'time');  % 修改place, 参数1-参数2-
end