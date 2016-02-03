function plot_centroids( model )
%Plots the centroids of the model
%   Detailed explanation goes here

    o = model_centroids( model );
    
    figure('name','centroids');
    scatter(o(:,1),o(:,2));
end

