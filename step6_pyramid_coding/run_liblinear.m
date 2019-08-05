function [mean_A] = run_liblinear_for(nRunning,concatenated_features,label_final, nClass, nRandSelectPerClass)


for running_times = 1:nRunning
[label_1, label_2] = select_code_label(label_final,nClass, nRandSelectPerClass);
    
        index_training = label_1;
        index_test = label_2;
        
        
        %set
        training_set = concatenated_features(:,index_training);
        training_set = training_set';

        test_set = concatenated_features(:,index_test);
        test_set = test_set';


        %label
        training_set_label = label_final(:,index_training);
        training_set_label = training_set_label';

        test_set_label = label_final(:,index_test);
        test_set_label = test_set_label';
        
        %options = ['-c' num2str(c)];
        model = fitcecoc(training_set,training_set_label,'Learners','Linear','Coding','onevsall','ObservationsIn','columns');
        %model = train(double(training_set_label), sparse(training_set), '-c 1');
        %[predict_label, accuracy, dec_values] = predict(double(test_set_label), sparse(test_set), model);
        predict_label= predict(model,test_set);
        
        Accuracy(running_times) = accuracy(1);
        
        str = sprintf('loop: %d --> ratio: %6.4f', running_times, Accuracy(running_times));
        disp(str)     
end
    mean_A = Accuracy;