function [ model ] = Reg_init( model, dim, hid )
%Creates a regression model

    rng(model.seed);
    
    model.dim = dim;
    model.hid = hid;

    w_lim_low  = - 1 / sqrt(dim);
    w_lim_high = - w_lim_low;
    
    model.wOut = unifrnd(w_lim_low, w_lim_high, model.hid + model.isBias2, dim);
    if(model.isTied)
        temp  = model.wOut(1:end-model.isBias2,:)';
        model.wIn = [temp ; unifrnd(w_lim_low, w_lim_high,model.isBias1,size(temp,2))];
    else
        model.wIn  = unifrnd(w_lim_low,w_lim_high,dim+model.isBias1,model.hid);        
    end
    if(model.isBias1)
        model.wIn(end,:) = model.wIn(end,:);
    end
    if(model.isBias2)
        model.wOut(end,:) = model.wOut(end,:);
    end
    
    model.wInUp= zeros(dim+model.isBias1,model.hid);
    model.wOutUp= zeros(model.hid+model.isBias2,dim);
    
end

