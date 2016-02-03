function f = plot_error( model )
%Plots the error 

    f = figure('name','error');
    plot(model.err_train,'color','blue');
    hold on
    plot(model.err_test,'color','red');
    hold on
    plot(model.err_null,'color','green');
    legend('Training','Testing','Null');

end

