function plot_morph( data, isAnim, moves )
%Plots the morph of the dataset
%   Detailed explanation goes here

    figure('name','Morphing dataset');
    
    if(isAnim)
        start = 1;
    else
        start = moves;
    end
    
    for m=start:moves
        scatter(data{m}(1,:),data{m}(2,:));
        shg
    end

end

