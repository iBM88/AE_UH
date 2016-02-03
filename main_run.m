csvname = 'experiments.csv';
folder_experiments = '/experiments/';
folder_data = '/data/';

csvfile = fullfile(pwd,folder_experiments,csvname)

[ result ] = read_csv( csvfile );

start = 1;

for number=start:numel(result)
    fprintf('******* model\t%s\n',num2str(number));
    main_model;                 
end