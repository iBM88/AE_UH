%%  Framework for Generating toy datasets with known variations
%   Behrang Mehrparvar
%   behrang.mehrparvar@gmail.com

%   This code generates a dataset with two normal distributions

%   Please refer to thesis/paper for more details

%  Generate Dataset
setting1.count = 6000;      % number of samples


%   noise
setting1.noise.parameter = 0.001;

mu1 = 0;
sigma1 = 1;

v1 = normrnd(mu1,sigma1,setting1.count,1)

v = v1;

figure;hist(v,200);

% Save Dataset
filename = 'dataset0.mat';
if(~exist('folder_data'))
    folder_data = '\data\';
end
data_raw = v; data_var = v; setting = setting1;
save(fullfile(pwd,folder_data, filename),'data_raw','data_var','setting');