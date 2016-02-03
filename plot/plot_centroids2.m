function  plot_centroids2( train_x,model,bounds )
%Plots the centroids and direction of hidden units
    figure('name','centroids');

    axis equal;
    
    scatter(train_x(1,:),train_x(2,:));
    o_1 = model_centroids( model,bounds(2) );
    o_5 = model_centroids( model,(bounds(2)-bounds(1))/2 );
    o_0 = model_centroids( model,bounds(1) );

    for h=1:model.hid
        hold on
        line([o_0(h,1);o_5(h,1);o_1(h,1)],[o_0(h,2);o_5(h,2);o_1(h,2)],'LineWidth',2,'Color','black');
    end
    hold on
    scatter(o_1(:,1),o_1(:,2), 'MarkerFaceColor','red');
    hold on
    scatter(o_5(:,1),o_5(:,2), 'MarkerFaceColor','green');
    hold on
    scatter(o_0(:,1),o_0(:,2), 'MarkerFaceColor','black');

    axis equal;


end

