%%  Framework for Generating toy datasets with known variations
%   Behrang Mehrparvar
%   behrang.mehrparvar@gmail.com

%   This code generates a dataset with two normal distributions

%   Please refer to thesis/paper for more details

%  Generate Dataset
setting1.count = 8000;      % number of samples

%   noise
setting1.noise.parameter = 0.0;


x = [1:0.1:10];
y1 = 6*x;
y2 = 6*x+12;

var = x;


data = [x x;y1 y2]';

% Save Dataset
filename = 'dataset12.mat';
if(~exist('folder_data'))
    folder_data = '\data\';
end
data_raw = data; data_var = var; setting = setting1;
save(fullfile(pwd,folder_data, filename),'data_raw','data_var','setting');