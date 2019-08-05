load('./step6_pyramid_coding/final_rand31_groupsize30_caltech101.mat');

nRunning=10;
nRandSelectPerClass=30;   
nClass=101;
acc = zeros(1,nRunning);

tic
for running_times = 1:nRunning
[label_1, label_2] = select_code_label(label_final,nClass, nRandSelectPerClass);
        index_training = label_1;
        index_test = label_2;
   
        %set
        training_set = code_final(:,index_training);
        training_set = training_set';

        test_set = code_final(:,index_test);
        test_set = test_set';

        %label
        training_set_label = label_final(:,index_training);
        training_set_label = training_set_label';

        test_set_label = label_final(:,index_test);
        test_set_label = test_set_label';
        
        %options = ['-c' num2str(c)];
        model = train(double(training_set_label), sparse(training_set), '-c 1');
        [predict_label(:,running_times), accuracy, dec_values] = predict(double(test_set_label), sparse(test_set), model);
        
        Accuracy(running_times) = accuracy(1);
        str = sprintf('loop: %d --> ratio: %6.4f', running_times, Accuracy(running_times));
        disp(str)     
end
time=toc
    acc = Accuracy;  
    acc_mean = mean(acc)
    acc_std=std(acc) 
    
name_class={'1', '2', '3', '4', '5', '6', '7', '8', '9','10', '11', '12', '13', '14', '15', '16', '17', '18' ,'19', '20', ...
            '21', '22', '23', '24', '25', '26', '27', '28', '29','30', '31', '32', '33', '34', '35', '36', '37', '38' ,'39', '40', ...
            '41', '42', '43', '44', '45', '46', '47', '48', '49','50', '51', '52', '53', '54', '55', '56', '57', '58' ,'59', '60', ...
            '61', '62', '63', '64', '65', '66', '67', '68', '69','70', '71', '72', '73', '74', '75', '76', '77', '78' ,'79', '80', ...
            '81', '82', '83', '84', '85', '86', '87', '88', '89','90', '91', '92', '93', '94', '95', '96', '97', '98' ,'99', '100', '101'};
addpath(genpath('Compute_confusion_matrix'))
max_id = find(acc==max(acc)); 
if size(max_id,2)>1
max_id = max_id(1);
end
load num_in_class
% [confusion_matrix]=compute_confusion_matrix(predict_label(:,max_id),num_in_class-nRandSelectPerClass,name_class);
    


