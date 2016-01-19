function [ e, ev, h ] = AE_feedforward( data, target ,AE)

    z  = [data;ones(AE.isBias1,size(data,2))]' * AE.wIn;
    h  = func(z,AE.p_func1);
     
    z2 = [h ones(size(h,1),AE.isBias2)] *  AE.wOut;
    o  = func(z2,AE.p_func2);
    
    [e, ev] = MSE(o',target);    
    
end

