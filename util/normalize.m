function [ result ] = normalize( data, bounds )
%Normalizes data between a and b
%   Detailed explanation goes here
    
    a = bounds(1);
    b = bounds(2);
    
    mn = min(data')';
    mx = max(data')';
    sz = size(data,2);
    
    result = data - repmat(mn,1,sz);
    temp = mx - mn;
    temp(temp==0)=1;
    result = result ./ repmat(temp,1,sz);
    
    
    result = result * (b-a);
    result = result + a;
    
end

