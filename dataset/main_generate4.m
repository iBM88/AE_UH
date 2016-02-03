%%  Framework for Generating toy datasets with known variations
%   Behrang Mehrparvar
%   behrang.mehrparvar@gmail.com

%   This code generates a dataset with two normal distributions

%   Please refer to thesis/paper for more details

%  Generate Dataset
setting1.count = 6000;      % number of samples

%   noise
setting1.noise.parameter = 0.0;

mu = [-5 0]; 
SIGMA = [1 0; 0 1]; 
X1 = mvnrnd(mu,SIGMA,setting1.count); 
mu = [5 0]; 
SIGMA = [1 0; 0 1]; 
X2 = mvnrnd(mu,SIGMA,setting1.count); 

X = [X1;X2];

figure;scatter(X(:,1),X(:,2));axis equal;

% Save Dataset
filename = 'dataset4.mat';
if(~exist('folder_data'))
    folder_data = '\data\';
end
data_raw = v; data_var = v; setting = setting1;
save(fullfile(pwd,folder_data, filename),'data_raw','data_var','setting');