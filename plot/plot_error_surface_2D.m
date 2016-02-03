function [  ] = plot_error_surface_2D( model, data, isSep, isAnim )
%Plots the 2D error surface

    assert(size(data,1) == 2,'Data should be 2 dimensional');
    
    if(~isSep)
        figure('name','error surface');
    end
    
    if(isAnim)
        start = 1;
    else
        start = model.p_iter;
    end
    
    for it = start:model.p_iter
        
        sprintf('plotting error surface iteration: %s',num2str(it));
        
        space = (max(data(1,:))-min(data(1,:)))/100;
        x = min(data(1,:)):space:max(data(1,:));
        space = (max(data(2,:))-min(data(2,:)))/100;
        y = min(data(2,:)):space:max(data(2,:));
        [X,Y] = meshgrid(x,y);
        
        Z = AE_feedforward_grid_2D( X,Y, model,it);
       
        if(isSep)
            figure('name',strcat('iteration: ',num2str(it)));
        end
        
%         v = [0,0];
%         surf(X,Y,Z);
        pcolor(Z);
        
%         hold on;
%         scatter(data);

        title(strcat('iteration: ',num2str(it)));
        shg
    end

end

