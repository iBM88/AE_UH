function [ AE ] = AE_train( AE, train_x, test_x, isVerbose)
%Trains the autoencoder

    AE.dim = size(train_x,1);
    
    samples = size(train_x,2);
    
    err_train = []; err_vec_train = []; 
    err_test  = []; err_vec_test  = []; 
    alpha_change = [];
    AE.all_wIn = zeros(AE.p_iter, size(AE.wIn,1), size(AE.wIn,2));
    AE.all_wOut = zeros(AE.p_iter, size(AE.wOut,1), size(AE.wOut,2));
        
    temp_wIn = zeros(size(AE.wIn));
    temp_wOut = zeros(size(AE.wOut));
    
    for it = 1:AE.p_iter
                    
        for b = 0 : ceil(samples/AE.p_batch)-1
        
            wInUp_temp = AE.wInUp;
            wOutUp_temp = AE.wOutUp;
        
            p_start = b*AE.p_batch+1;
            p_end   = (b+1)*AE.p_batch;
            
            if(p_end > samples)
                p_end = samples;
            end

            data  = train_x(:,p_start:p_end);

            AE.z1 = [data;ones(AE.isBias1,size(data,2))]' * AE.wIn;
            AE.h  = func(AE.z1,AE.p_func1);

            AE.z2 = [AE.h ones(size(AE.h,1),AE.isBias2)] * AE.wOut;
            AE.o  = func(AE.z2,AE.p_func2);

            AE.e = (AE.o' - data);

            AE.dOut = AE.e' .* func(AE.z2,AE.p_func2_d);
            AE.wOutUp = ([AE.h ones(size(AE.h,1),AE.isBias2)])' * AE.dOut;

            AE.dIn  = AE.dOut * AE.wOut';
            AE.wInUp  = [data;ones(AE.isBias1,size(data,2))] * (AE.dIn(:,1:end-AE.isBias2) .* func(AE.z1,AE.p_func1_d));

            temp_wOutUp =  AE.p_rate* AE.wOutUp ...
                        + AE.p_decay * norm(AE.wOut,1) ...
                        + AE.p_momentum * wOutUp_temp;

            temp_wInUp =  AE.p_rate * AE.wInUp ...
                        + AE.p_decay * norm(AE.wIn,1) ...
                        + AE.p_momentum * wInUp_temp;
            if(AE.isTied)
                AE.wIn = AE.wIn ...
                            - (temp_wInUp + [temp_wOutUp(1:end-AE.isBias2,:)';zeros(AE.isBias1,size(temp_wInUp,2))])/2;
                AE.wOut = AE.wOut ...
                            - ([temp_wInUp(1:end-AE.isBias1,:) zeros(size(temp_wOutUp,2),AE.isBias2)]' + temp_wOutUp)/2;
            else
                AE.wOut = AE.wOut - temp_wOutUp;
                AE.wIn  = AE.wIn - temp_wInUp;
            end
        
        end % end batch 
            
        [uns_er_train, error_vector_train] =  AE_feedforward( train_x, train_x ,AE);
        err_vec_train = [err_vec_train; error_vector_train'];
        err_train = [err_train;uns_er_train];
        
        [uns_er_test, error_vector_test] =  AE_feedforward( test_x, test_x ,AE);
        err_vec_test = [err_vec_test; error_vector_test'];
        err_test = [err_test;uns_er_test];                
               
        alpha = [];
        for h = 1:size(AE.wIn,2)-AE.isBias1
            alpha = [alpha angle(AE.wIn(1:end-AE.isBias1,h),temp_wIn(1:end-AE.isBias1,h))];
        end
        alpha_change = [alpha_change; alpha];
        
        if(isVerbose)
            fprintf('iteration: %d/%d \tError: %3.3f\n',it,AE.p_iter,uns_er_train);
        end
        temp_wIn = AE.wIn;
        temp_wOut = AE.wOut;
        
        AE.all_wIn(it,:,:) = temp_wIn;
        AE.all_wOut(it,:,:) = temp_wOut;
        
    end % end iteration
    AE.err_train        = err_train;
    AE.err_vec_train    = err_vec_train;
    AE.err_test         = err_train;
    AE.err_vec_test     = err_vec_train;
    AE.alpha_change     = alpha_change;
    AE.samples          = samples;
end

