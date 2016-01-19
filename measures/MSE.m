function [ e, ev ] = MSE( truth, output )
%   Calculate mean squared error
    %e = mean(0.5*mean((truth - output).^2));
    ev = mean((truth - output).^2,2);
    e = 0.5*(sum(ev));   % I used mean to be comparable
end

