tic
clear;
clc;

param.K = 32;
param.lambda = 0.35;
param.numThreads = 4;
param.iter = 500;
param.mode = 0;

address1 = './step4_dic2_trainning';

load('./step3_firstlayer_coding/dic1_groupsize30_rand30_mex');

X = dic1_groupsize30_rand30_mex;


Dic_SPAMS = mexTrainDL(X,param);

a = 'method2_dic2_rand30_groupsize30_mex';

cd(address1)
save(a,'Dic_SPAMS');