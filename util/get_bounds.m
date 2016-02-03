function [ bounds ] = get_bounds( func )
%Get bounds
%   Detailed explanation goes here

    switch func
        case 'sigm'
            bounds = [0 1];
        case 'softplus'
            bounds = [0 1];
        case 'tanh'
            bounds = [-0.5 0.5];
        case 'linear'
            bounds = [-1 1];
        case 'tanh_step'
            bounds = [-0.5,0.5];
    end    
    
end

