%%  Framework for Generating toy datasets with known variations
%   Behrang Mehrparvar
%   behrang.mehrparvar@gmail.com

%   This code generates a dataset with two normal distributions

%   Please refer to thesis/paper for more details

%  Generate Dataset
setting1.count = 6000;      % number of samples


%   noise
setting1.noise.parameter = 0.001;

mu1 = -2;      mu2 = 2;
sigma1 = 1;  sigma2 = 1;

v1 = normrnd(mu1,sigma1,setting1.count,1);
v2 = normrnd(mu2,sigma2,setting1.count,1);

v = [v1; v2];

figure;hist(v,200);

% Save Dataset
filename = 'dataset2.mat';
if(~exist('folder_data'))
    folder_data = '\data\';
end
data_raw = v; data_var = [v1 zeros(size(v2)); v2 zeros(size(v1))]; setting = setting1;
save(fullfile(pwd,folder_data, filename),'data_raw','data_var','setting');