%%  TODO
%   1. implement sampling with dependency
%   2. noise on variation not raw data
%   3. other types of noise

function [ data_var, data_raw ] = Generate_dataset( setting )
%Generate_dataset Generates a toy dataset with provided input settings
%   Based on the type of variation and other parameters, this function
%   generates a toy example

    data_var = zeros(setting.count,numel(setting.var));
    el = numel(setting.var);
    dim = prod(setting.dim);
    
    data_raw = zeros(setting.count,dim);

    %   Generate datasets
    for s=1:setting.count
        for f=1:el
            %   Generate variations data
            switch (setting.var{f}.type)
                case VARIATION_TYPE.RESPONSE
                    data_var(s,f) = binornd(1,setting.var{f}.parameter);
                    %   Generate raw data
                    if(data_var(s,f))
                        switch (setting.combination)
                            case VARIATION_COMBINATION.OR
                                data_raw(s,:) = max(data_raw(s,:),full(setting.var{f}.map(:))');
                        end
                    end
            end
        end
        %   Add raw noise
        noise_pattern = binornd(1,setting.noise.parameter,1,prod(setting.dim));
        data_raw(s,:) = max(data_raw(s,:),noise_pattern);
    end
        

end
