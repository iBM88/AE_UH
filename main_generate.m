%%  Framework for Generating toy datasets with known variations
%   Behrang Mehrparvar
%   behrang.mehrparvar@gmail.com

%   This code provides a framework and protocol for generating toy datasets 
%   with known variatios.

%   You can use it as a template code to generate datasets

%   Please refer to thesis/paper for more details

%%   Setting 1: image strokes

%  Dataset Definition

%   size of raw input
setting1.dim = [30 30];
%   type of distribution
setting1.var{1}.type = VARIATION_TYPE.RESPONSE;
setting1.var{2}.type = VARIATION_TYPE.RESPONSE;
setting1.var{3}.type = VARIATION_TYPE.RESPONSE;
setting1.var{4}.type = VARIATION_TYPE.RESPONSE;
setting1.var{5}.type = VARIATION_TYPE.RESPONSE;
%   parameter of distribution
setting1.var{1}.parameter = 0.1;    % Probability of success in Bernoulli
setting1.var{2}.parameter = 0.2;    % Probability of success in Bernoulli
setting1.var{3}.parameter = 0.01;   % Probability of success in Bernoulli
setting1.var{4}.parameter = 0.1;    % Probability of success in Bernoulli
setting1.var{5}.parameter = 0.3;    % Probability of success in Bernoulli
%   mapping between the variation and raw data
%   note: used the map2code to generate code for patter
setting1.var{1}.map = sparse([5,6,6,6,7,7,7,7,7,8,8,8,8,8,8,8,9,9,9,9,10,10,10,11],[4,3,4,5,2,3,4,5,6,1,2,3,4,5,6,7,3,4,5,6,3,4,5,4],ones(1,24),30,30);
setting1.var{2}.map = sparse([13,14,15,16,17,18,19,20,20,21,22,22,23,23,24,24,25,25],[30,30,30,30,29,29,29,28,29,28,27,28,26,27,25,26,24,25],ones(1,18),30,30);
setting1.var{3}.map = sparse([7,7,7,7,7,7,7,7,8,9,10,11,12,13,14],[2,3,4,5,6,7,8,9,9,9,9,9,9,9,9],ones(1,15),30,30);
setting1.var{4}.map = sparse([25,25,25,26,26,27,27],[4,5,6,4,6,4,6],ones(1,7),30,30);
setting1.var{5}.map = sparse([2,3,4,5,6,7,8,9,10,11],[11,11,11,11,11,11,11,11,11,11],ones(1,10),30,30);
%   combination method
setting1.combination = VARIATION_COMBINATION.OR;
%   noise
setting1.noise.parameter = 0.001;


%  Generate Dataset
setting1.count = 600;      % number of samples
[ data_var1, data_raw1 ] = Generate_dataset( setting1 );

Show_data( data_raw1, setting1.dim );

% Save Dataset
filename = 'dataset1.mat';
if(~exist('folder_data'))
    folder_data = '\data\';
end
data_raw = data_raw1; data_var = data_var1; setting = setting1;
save(fullfile(pwd,folder_data, filename),'data_raw','data_var','setting');