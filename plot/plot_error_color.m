function [ e ] = plot_error_color( data, rec )
%Plots the error of each sample
%   Detailed explanation goes here

    e = sum((data-rec).^2);
    e_norm = normalize(e',[0 1]);
    figure('name','error colors');
    scatter(data(1,:),data(2,:),5,e_norm','filled');
    colormap jet
    colorbar
end

