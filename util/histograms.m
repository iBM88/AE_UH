function f_hist = histograms( data,title )
%   Plots the histogram
    
    c = size(data,2);
    f_hist = figure('name',title);
    for i=1:c
        subplot(c,1,i);
        hist(data(:,i),100);
    end

end

