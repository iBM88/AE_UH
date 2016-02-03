%%  Generates experiments
%   Behrang Mehrparvar
%   behrang.mehrparvar@gmail.com

%   Each experiment is saved in a mat file with an initialized auto-encoder
%   with parameters set

%   Please refer to thesis/paper for more details

%%  Initialize
close all;
clear all;

%   Experiment parameters
tag = '_paper1_';
folder = '/experiments/';
csvfile = ('experiments.csv');
list_dataset  = {'dataset0','dataset2','dataset3','dataset4','dataset5'};
experiment.cut      = 2/3;
experiment.seed     = 906706468;

%   Auto-encoder learning parameters
list_iter         = [50]; 
list_rate         = [0.001 0.01 0.1  1]; 
list_momentum     = [0.0]; 
list_decay        = [0.0]; 
list_batch        = [1 20 200];

%   Auto-encoder architecture parameters
list_isBias1        = [0 1]; 
list_isBias2        = [0 1]; 
list_isTied         = [0 1]; 
list_func1          = {'sigm','tanh','linear','softplus'}; 
list_func2          = [0 1]; 
list_hid            = [1 2 5 10 20];
list_sup            = [0];

number = 0;

for i_dataset = 1:numel(list_dataset)
    for i_iter = 1:size(list_iter,2)
        for i_rate = 1:size(list_rate,2)
            for i_momentum = 1:size(list_momentum,2)
                for i_decay = 1:size(list_decay,2)
                    for i_batch = 1:size(list_batch,2)
                        for i_isBias1 = 1:size(list_isBias1,2)
                            for i_isBias2 = 1:size(list_isBias2)
                                if ~(list_isBias1(i_isBias1)==0 && list_isBias2(i_isBias2)==1)
                                    for i_isTied = 1:size(list_isTied,2)
                                        for i_func1 = 1:size(list_func1,2)
                                            for i_func2v = 1:size(list_func2,2)
                                                if(list_func2(i_func2v))
                                                    p_func2 = list_func1{i_func1};
                                                else
                                                    p_func2 = 'linear';                                                    
                                                end
                                                for i_sup=1:size(list_sup,2)

                                                    number = number+1;

                                                    experiment.dataset = list_dataset{i_dataset};
                                                    experiment.supervision = list_sup(i_sup);

                                                    num_str=sprintf('%06d',number);

                                                    if list_sup(i_sup)    % Supervised

                                                        model = Reg_construct( list_isBias1(i_isBias1), list_isBias2(i_isBias2), ...
                                                            list_isTied(i_isTied), list_func1{i_func1}, p_func2, ...
                                                            experiment.seed, 0, 0, list_iter(i_iter), list_rate(i_rate), ...
                                                            list_momentum(i_momentum), list_decay(i_decay), list_batch(i_batch), experiment.dataset);

                                                        filename = strcat('exp_sup',tag,num_str,'.mat');

                                                    else    % Unsupervised

                                                        for i_hid = 1:size(list_hid,2)
                                                            model = AE_construct( list_isBias1(i_isBias1), list_isBias2(i_isBias2), ...
                                                                list_isTied(i_isTied), list_func1{i_func1}, p_func2, ...
                                                                experiment.seed, list_hid(i_hid), 0, list_iter(i_iter), list_rate(i_rate), ...
                                                                list_momentum(i_momentum), list_decay(i_decay), list_batch(i_batch), experiment.dataset);

                                                            filename = strcat('exp_uns',tag,num_str,'.mat');
                                                        end
                                                    end

                                                    row = {experiment.dataset, num2str(list_sup(i_sup)), num2str(model.isBias1 ) , ...
                                                        num2str(model.isBias2 ) , num2str(model.isTied ) , (model.p_func1) ,(model.p_func2 ) , ...
                                                        num2str(experiment.seed ) ,num2str(model.hid ) , num2str(model.p_iter ) , ...
                                                        num2str(model.p_rate ) ,num2str(model.p_momentum ) , num2str(model.p_decay ) ,num2str(model.p_batch)};

                                                    save(fullfile(pwd,folder, filename),'experiment','model');

                                                    fid = fopen(fullfile(pwd,folder,csvfile),'a');
                                                    fprintf(fid,'%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s \n',row{1,:});
                                                    fclose('all');

                                                end

                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end