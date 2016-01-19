function [ model ] = Model_construct( isBias1, isBias2, isTied, p_func1, p_func2, seed, hid, dim,...
                           p_iter, p_rate, p_momentum, p_decay, p_batch, filename)
%Constructor function for model
    model.isBias1 = isBias1;
    model.isBias2 = isBias2;
    model.isTied = isTied;
    model.seed = seed;
    model.dim = dim;
    model.hid = hid;
    
    model.p_func1 = p_func1;
    model.p_func1_d = strcat(p_func1,'_d');
    model.p_func2 = p_func2;
    model.p_func2_d = strcat(p_func2,'_d');
        
    model.p_iter = p_iter; model.p_rate = p_rate; model.p_momentum = p_momentum; 
    model.p_decay=p_decay; model.p_batch = p_batch;
    
    model.filename = filename;

end

