%% TODO: SHOULD BE FIXED !!!

function [ null_x ] = genarate_null( data )
%generate Null dataset
%   Null dataset is a uniform distribution of points over the whole bounded
%   input space

    dim = size(data,2);
    gap = 100;
    
    null_x = [];
    for d = 1:dim
        space = (max(data(1,:))-min(data(1,:)))/gap;
        x(d) = min(data(1,:)):space:max(data(1,:));
    end
    [X] = meshgrid(x);

end

