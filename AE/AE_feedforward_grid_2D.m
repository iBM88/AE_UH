function [ Z ] = AE_feedforward_grid_2D( X,Y, AE, iter)
%Fed forward the grid of input

    assert(sum(size(X)==size(Y))==2,'size of two input grids should be the same!');

    Z = [];
    
    for i = 1:size(X,1)
        for j = 1:size(X,2)
       
            [ e, ev, h ] = AE_feedforward( [X(i,j);Y(i,j)], [X(i,j);Y(i,j)] ,AE, iter);
            
            Z(i,j) = e;
            
        end
    end    
    
end

