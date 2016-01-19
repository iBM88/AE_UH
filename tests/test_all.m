%%  Test all
%   Behrang Mehrparvar
%   behrang.mehrparvar@gmail.com

%   This code runs simple tests on the existing codes

%   Please refer to thesis/paper for more details

%%  Initialize
close all;
clear all;

folder_data = '/test_data/';
if(~ exist(fullfile(pwd,folder_data),'dir'))
    mkdir(fullfile(pwd,folder_data));
end
folder_results = '/test_results/';
if(~ exist(fullfile(pwd,folder_results),'dir'))
    mkdir(fullfile(pwd,folder_results));
end
folder_experiments = '/test_experiments/';
if(~ exist(fullfile(pwd,folder_experiments),'dir'))
    mkdir(fullfile(pwd,folder_experiments));
end
csvname = 'experiments.csv';
if(~ exist(fullfile(pwd,folder_experiments,csvname), 'file'))    
    fid = fopen(fullfile(pwd,folder_experiments,csvname),'w');
    row = {'exp','dataset', 'isSup', 'isBias1' , ...
        'isBias2', 'isTied' , 'func1', 'func2', ...
        'seed', 'hidden' , 'iter' , ...
        'rate', 'momentum' , 'decay', 'batch'};
    fprintf(fid,'%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s \n',row{1,:});
    fclose('all');
end
%%  Run
test_generate;

test_experiments;

csvname = 'experiments.csv';

csvfile = fullfile(pwd,folder_experiments,csvname)

[ result ] = read_csv( csvfile );

for number=1:numel(result)
    display(strcat('******* model\t',num2str(number)));
    test_model;                 
end
%test_unsupervised;