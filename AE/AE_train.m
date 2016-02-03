function [ AE ] = AE_train( AE, train_x, test_x, isVerbose)
%Trains the autoencoder

    % generate null dataset
    null_x = zeros(size(train_x));    % TODO: should be fixed

    AE.dim = size(train_x,1);
    
    samples = size(train_x,2);
    
    err_train = []; err_vec_train = [];  
    err_test  = []; err_vec_test  = [];  
    err_null  = []; err_vec_null  = []; 
    alpha_change = [];
    beta_change = [];
    gamma_change = [];
    bias_movement = [];
    %AE.all_wIn = zeros(AE.p_iter, size(AE.wIn,1), size(AE.wIn,2));
    %AE.all_wOut = zeros(AE.p_iter, size(AE.wOut,1), size(AE.wOut,2));
        
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
        
        [uns_er_null, error_vector_null] =  AE_feedforward( null_x, null_x ,AE);
        err_vec_null = [err_vec_null; error_vector_null'];
        err_null = [err_null;uns_er_null];                
               
        alpha_  = [];
        beta_   = [];
        gamma_   =[];
        bias_dist_movement_ = [];
        for h = 1:AE.hid
            alpha_ = [alpha_ angle(AE.wIn(1:end-AE.isBias1,h),temp_wIn(1:end-AE.isBias1,h))];
            beta_  = [beta_  angle(AE.wOut(h,:),temp_wOut(h,:))];
            if(AE.isBias2)
                gamma_ = [gamma_ angle(AE.wOut(end,:),temp_wOut(end,:))];
                bias_dist_movement_ = [bias_dist_movement_ sum((AE.wOut(end,:)-temp_wOut(end,:)).^2)];
            end
        end
        alpha_change    = [alpha_change; alpha_];
        beta_change     = [beta_change; beta_];
        gamma_change    = [gamma_change; gamma_];
        bias_movement    = [bias_movement; bias_dist_movement_];
        
        if(isVerbose)
            fprintf('iteration: %d/%d \tTrain Error: %3.6f\tTest Error: %3.6f\tNULL Error: %3.6f\n',it,AE.p_iter,uns_er_train,uns_er_test,uns_er_null);
        end
        temp_wIn = AE.wIn;
        temp_wOut = AE.wOut;
        
%         AE.all_wIn(it,:,:) = temp_wIn;
%         AE.all_wOut(it,:,:) = temp_wOut;
        AE.all_wIn{it} = temp_wIn;
        AE.all_wOut{it} = temp_wOut;
        
    end % end iteration
    AE.err_train        = err_train;
    AE.err_vec_train    = err_vec_train;
    AE.err_test         = err_test;
    AE.err_vec_test     = err_vec_test;
    AE.err_null         = err_null;
    AE.err_vec_null     = err_vec_null;
    AE.alpha_change     = alpha_change;
    AE.beta_change      = beta_change;
    AE.gamma_change     = gamma_change;
    AE.bias_dist_movement = bias_movement;
    AE.samples          = samples;
end

