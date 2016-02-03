%%  Framework for Generating toy datasets with known variations
%   Behrang Mehrparvar
%   behrang.mehrparvar@gmail.com

%   This code generates a dataset with two normal distributions

%   Please refer to thesis/paper for more details

%  Generate Dataset
setting1.count = 8000;      % number of samples

%   noise
setting1.noise.parameter = 0.0;

var = [];

mu = [1,1];
sigma = [10,5;5,10];
data1 = mvnrnd(mu,sigma,setting1.count/4);
var   = [var;1*ones(size(data1,1))];

data = [data1];

% Save Dataset
filename = 'dataset8.mat';
if(~exist('folder_data'))
    folder_data = '\data\';
end
data_raw = data; data_var = var; setting = setting1;
save(fullfile(pwd,folder_data, filename),'data_raw','data_var','setting');