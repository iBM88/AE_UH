function [ o ] = model_centroids( model, activation )
%Finds the centroids of regions
%   Detailed explanation goes here
        
%     cent_int = 0:2^model.hid-1; % all codes
%     cent_str = dec2bin(cent_int);
        
    cent_int = 0:model.hid-1; % all codes
    cent_str = dec2bin([2.^cent_int]);
    
    cent_bin = cent_str-'0';

    z2 = [activation * cent_bin ones(size(cent_bin,1),model.isBias2)] *  model.wOut;
    o  = func(z2,model.p_func2);   

end

