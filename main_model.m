%%  Unsupervised learning of representation
%   Behrang Mehrparvar
%   behrang.mehrparvar@gmail.com

%   This code runs unsupervised learning of the representation of the data
%   By setting the parameters in experiment design, you can define the
%   architecture of the network and the learning parameters

%   Please refer to thesis/paper for more details

isVerbose = true;

%%	Load experiment
%number = 1;                                 % Read from command line!!!!!
num_str=sprintf('%06d',number);

folder_results = '/results/';

tag = {'sup','uns'};
tag2 = '_paper1_';

for t=1:2
  
    filename = strcat('exp_',tag{t},tag2,num_str,'.mat');
    file = fullfile(pwd, folder_experiments, filename);
    if(exist(file,'file'))
        load(file,'experiment','model');
        display(strcat('Loading file: ',filename));
        %%	Load Data
        filename = strcat(experiment.dataset,'.mat');
        load(fullfile(pwd, folder_data, filename));

        %%   Partition Data
        cut = experiment.cut;
        dim = size(data_raw,2);
        hid = size(data_var,2);
        [ train_x, test_x, train_v, test_v ] = Partition_data( data_raw, data_var, cut );

        %% Train the model
        switch(experiment.supervision)
            case 0
                model      = AE_init( model, dim );
                model      = AE_train( model, train_x', test_x', isVerbose);
            case 1
                model      = Reg_init( model, dim, hid );
                model      = Reg_train( model, train_x', test_x', train_v', test_v', isVerbose);
        end

        %% Save Results
        experiment.err_train        = model.err_train;
        experiment.err_vec_train    = model.err_vec_train;
        experiment.err_test         = model.err_train;
        experiment.err_vec_test     = model.err_vec_train;
        experiment.alpha_change     = model.alpha_change;

        num_str=sprintf('%06d',number);
        if(experiment.supervision)
            filename = strcat('res_sup',num_str,'.mat');
        else
            filename = strcat('res_uns',num_str,'.mat');
        end
        save(fullfile(pwd,folder_results, filename),'experiment','model');
    end
end