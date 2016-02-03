function [distances, f_weight_rel] = weight_relations(model, isAnim)
%Checks the relations between the encoder and decoder weights
%   Detailed explanation goes here
    
    fprintf('***** Parameter Relations:\n');
    fprintf(['  Decoder Bias:  \t' repmat('%f\t',1,model.dim) '\n'], model.isBias2*model.wOut(end,:));
    fprintf(['  Encoder biases:\t' repmat('%f\t',1,model.hid) '\n'], model.isBias1*model.wIn(end,:));
   
%     for h=1:model.hid
%         fprintf('  Unit %d of %d:\n',h,model.hid);
%     end


    distances = [];
    
    start = 1;
    if(~isAnim)
        start = model.p_iter;
    end
    
    f_weight_rel = figure('name','Encoder and Decoder weights');
    axis equal;
    for it=start:model.p_iter
        
        clf
        
        wIn  = model.all_wIn{it} (1:end-model.isBias1,:);
        wOut = model.all_wOut{it}(1:end-model.isBias2,:);
    
        scatter(wOut(:,1),wOut(:,2),'red');
        hold on;
        scatter(wIn(1,:),wIn(2,:),'blue');
        if(model.isBias2)
            hold on;
            scatter(model.all_wOut{it}(end,1),model.all_wOut{it}(end,2),'filled','black');
        end
        legend('Decoder','Encoder','Decoder Bias');
        for h=1:model.hid
            hold on;
            line([wIn(1,h);wOut(h,1)],[wIn(2,h);wOut(h,2)]);
        end

        shg       
        
        pause(1);
        
        distances(it,:) = sum((wIn - wOut').^2);
        
    end
end

