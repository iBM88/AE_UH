function [ result ] = AE_generate( data, model, moves )
%Generates samples along moves
%   Detailed explanation goes here

    o = data';
    for m = 1:moves
        [ e, ev, h, o ] = AE_feedforward( o', o' ,model);
        result{m} = o';
    end

end

