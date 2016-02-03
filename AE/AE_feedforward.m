function [ e, ev, h, o ] = AE_feedforward( data, target ,AE, iter)


    if(~exist('iter'))
        z  = [data;ones(AE.isBias1,size(data,2))]' * AE.wIn;
        h  = func(z,AE.p_func1);

        z2 = [h ones(size(h,1),AE.isBias2)] *  AE.wOut;
        o  = func(z2,AE.p_func2);

        [e, ev] = MSE(o',target); 
    else
        z  = [data;ones(AE.isBias1,size(data,2))]' * AE.all_wIn{iter};
        h  = func(z,AE.p_func1);

        z2 = [h ones(size(h,1),AE.isBias2)] *  AE.all_wOut{iter};
        o  = func(z2,AE.p_func2);

        [e, ev] = MSE(o',target); 
    end
   
    
end

