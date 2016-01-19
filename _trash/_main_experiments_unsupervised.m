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
folder = '/experiments/';
csvfile = ('experiments.csv');
list_dataset  = {'dataset1'};
experiment.cut      = 2/3;
experiment.seed     = 906706468;

%   Auto-encoder learning parameters
list_iter         = [200]; 
list_rate         = [0.0001 0.001 0.01 0.05 0.1 0.2 0.5 0.7 1]; 
list_momentum     = [0.0]; 
list_decay        = [0.0]; 
list_batch        = [20 200 2000 20000];

%   Auto-encoder architecture parameters
list_isBias1        = [0 1]; 
list_isBias2        = [0 1]; 
list_isTied         = [0 1]; 
list_func1        = {'sigm','tanh','linear','softplus'}; 
list_func2        = [ 0 1]; 
list_hid            = [1 5 10 100 200 1000];

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
                                                for i_hid = 1:size(list_hid,2)
                                                    
                                                    number = number+1;
                                                    
                                                    experiment.dataset = list_dataset{i_dataset};
                                                     
                                                    AE = AE_construct( list_isBias1(i_isBias1), list_isBias2(i_isBias2), ...
                                                        list_isTied(i_isTied), list_func1{i_func1}, p_func2, ...
                                                        experiment.seed, list_hid(i_hid), list_iter(i_iter), list_rate(i_rate), ...
                                                        list_momentum(i_momentum), list_decay(i_decay), list_batch(i_batch), experiment.dataset);
                                                    
                                                    row = {experiment.dataset, num2str(AE.isBias1 ) ,num2str(AE.isBias2 ) ,num2str(AE.isTied ) ,...
                                                        (AE.p_func1) ,(AE.p_func2 ) , num2str(experiment.seed ) ,num2str(AE.hid ) ,num2str(AE.p_iter ) ,...
                                                        num2str(AE.p_rate ) ,num2str(AE.p_momentum ) , num2str(AE.p_decay ) ,num2str(AE.p_batch)};
                                                    
                                                    num_str=sprintf('%06d',number);
                                                    filename = strcat('exp_usp',num_str,'.mat');
                                                    save(fullfile(pwd,folder, filename),'experiment','AE');

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