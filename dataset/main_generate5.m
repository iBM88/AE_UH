%%  Framework for Generating toy datasets with known variations
%   Behrang Mehrparvar
%   behrang.mehrparvar@gmail.com

%   This code generates a dataset with two normal distributions

%   Please refer to thesis/paper for more details

%  Generate Dataset
setting1.count = 6000;      % number of samples

%   noise
setting1.noise.parameter = 0.0;

X = Generate_moon;

figure;scatter(X(:,1),X(:,2));axis equal;

% Save Dataset
filename = 'dataset5.mat';
if(~exist('folder_data'))
    folder_data = '\data\';
end
data_raw = X(:,1:2); data_var = zeros(size(X,1)); setting = setting1;
save(fullfile(pwd,folder_data, filename),'data_raw','data_var','setting');