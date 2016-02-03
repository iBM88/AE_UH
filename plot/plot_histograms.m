function plot_histograms( data )
%Plots all histograms of data
    c = size(data,1);
    for i=1:c
        phat = betafit(data(:,i));
%         figure('name',strcat('item ',num2str(c),':', num2str(phat(1)),':',num2str(phat(1))));
%         hist(data(i,:),100);
        
        fprintf('%3.3f %3.3f \n',phat(1),phat(2));
    end

end

