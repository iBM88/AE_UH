function [ model ] = Reg_train( model, train_x, test_x, train_v, test_v, isVerbose)
%Trains the autoencoder

    model.dim = size(train_x,1);
    
    samples = size(train_x,2);
    
    err_train = []; err_vec_train = []; err_rec_train = []; err_rec_vec_train = [];
    err_test  = []; err_vec_test  = []; err_rec_test  = []; err_rec_vec_test  = [];
    alpha_change = [];
    model.all_wIn = zeros(model.p_iter, size(model.wIn,1), size(model.wIn,2));
    model.all_wOut = zeros(model.p_iter, size(model.wOut,1), size(model.wOut,2));
        
    temp_wIn = zeros(size(model.wIn));
    temp_wOut = zeros(size(model.wOut));
    
    for it = 1:model.p_iter
                    
        for b = 0 : ceil(samples/model.p_batch)-1
        
            wInUp_temp = model.wInUp;
        
            p_start = b*model.p_batch+1;
            p_end   = (b+1)*model.p_batch;
            
            if(p_end > samples)
                p_end = samples;
            end

            data  = train_x(:,p_start:p_end);
            out   = train_v(:,p_start:p_end);

            model.z1 = [data;ones(model.isBias1,size(data,2))]' * model.wIn;
            model.o  = func(model.z1,model.p_func1);

            model.e  = (model.o' - out);

            model.dIn = model.e' .* func(model.z1,model.p_func1_d);
            model.wInUp  = [data;ones(model.isBias1,size(data,2))] * (model.dIn(:,1:end));

            temp_wInUp =  model.p_rate * model.wInUp ...
                        + model.p_decay * norm(model.wIn,1) ...
                        + model.p_momentum * wInUp_temp;

            model.wIn  = model.wIn - temp_wInUp;
        
        end % end batch 
            
        [sup_er_train, error_vector_train, hid_train] =  Reg_feedforward( train_x, train_v ,model,1);
        err_vec_train = [err_vec_train; error_vector_train'];
        err_train = [err_train;sup_er_train];
        
        [sup_er_test, error_vector_test, hid_test] =  Reg_feedforward( test_x, test_v ,model, 1);
        err_vec_test = [err_vec_test; error_vector_test'];
        err_test = [err_test;sup_er_test];                
               
        alpha = [];
        for h = 1:size(model.wIn,2)-model.isBias1
            alpha = [alpha angle(model.wIn(1:end-model.isBias1,h),temp_wIn(1:end-model.isBias1,h))];
        end
        alpha_change = [alpha_change; alpha];
        
        if(isVerbose)
            fprintf('iteration encoder: %d/%d \tError: %3.3f\n',it,model.p_iter,sup_er_train);
        end
        temp_wIn = model.wIn;
        
        model.all_wIn(it,:,:) = temp_wIn;
        
    end % end iteration
    if(model.isTied)
        
    else
        for it = 1:model.p_iter

            for b = 0 : ceil(samples/model.p_batch)-1

                wOutUp_temp = model.wOutUp;

                p_start = b*model.p_batch+1;
                p_end   = (b+1)*model.p_batch;

                if(p_end > samples)
                    p_end = samples;
                end

                temp = hid_train';
                data  = temp(:,p_start:p_end)';
                out   = train_x(:,p_start:p_end);

                model.z2 = [data ones(size(data,1),model.isBias2)] * model.wOut;
                model.o  = func(model.z2,model.p_func2);

                model.e = (model.o' - out);

                model.dOut = model.e' .* func(model.z2,model.p_func2_d);
                model.wOutUp = ([data ones(size(data,1),model.isBias2)])' * model.dOut;

                temp_wOutUp =  model.p_rate* model.wOutUp ...
                            + model.p_decay * norm(model.wOut,1) ...
                            + model.p_momentum * wOutUp_temp;

                model.wOut = model.wOut - temp_wOutUp;

            end % end batch 
            
            [sup_er_rec_train, error_rec_vector_train] =  Reg_feedforward( train_x, train_v ,model,1);
            err_rec_vec_train = [err_rec_vec_train; error_rec_vector_train'];
            err_rec_train = [err_rec_train;sup_er_rec_train];

            [uns_er_rec_test, error_rec_vector_test] =  Reg_feedforward( test_x, test_v ,model,1);
            err_rec_vec_test = [err_rec_vec_test; error_rec_vector_test'];
            err_rec_test = [err_rec_test;uns_er_rec_test];                

            if(isVerbose)
                fprintf('iteration decoder: %d/%d \tError: %3.3f\n',it,model.p_iter,sup_er_train);
            end
            temp_wOut = model.wOut;

            model.all_wOut(it,:,:) = temp_wOut;

        end % end iteration
    end
    model.err_train        = err_train;
    model.err_vec_train    = err_vec_train;
    model.err_test         = err_train;
    model.err_vec_test     = err_vec_train;
    
    model.err_rec_train        = err_rec_train;
    model.err_rec_vec_train    = err_rec_vec_train;
    model.err_rec_test         = err_rec_test;
    model.err_rec_vec_test     = err_rec_vec_test;
    
    model.alpha_change     = alpha_change;
    model.samples          = samples;
end

