function [ e, ev, o ] = Reg_feedforward( data, target ,model, isEnc)

    if(isEnc)
        z  = [data;ones(model.isBias1,size(data,2))]' * model.wIn;
        o  = func(z,model.p_func1);

    else    %is decoder
        z2 = [data ones(size(data,1),model.isBias2)] *  model.wOut;
        o  = func(z2,model.p_func2);
    end
    [e, ev] = MSE(o',target);    
    
end

