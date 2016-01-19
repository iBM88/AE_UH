function [ train_x, test_x, train_v, test_v ] = Partition_data( data_raw, data_var, cut )
%Partition data into training and testset
%   Detailed explanation goes here

    %   Shuffle Dataset
    c = size(data_raw,1);
    ind = randperm(c);
    
    %   Partition data
    cut_point = ceil(c*cut);
    train_x = data_raw(ind(1:cut_point),:);
    train_v = data_var(ind(1:cut_point),:);    
    test_x = data_raw(ind(cut_point+1:end),:);
    test_v = data_var(ind(cut_point+1:end),:);

end

