%%  Plot 2D error surface
%   Behrang Mehrparvar
%   behrang.mehrparvar@gmail.com

%   This is the main code

%%  Initialize

clc;
clear all;
close all;

func = 'sigm';
bounds = get_bounds(func);

%%  Load Data

folder_data     = '/data/';
file_data       = 'dataset12.mat';
%file_data       = 'rect_balanced_preprocessed.mat';

file = fullfile(pwd, folder_data, file_data);
load(file)
data = normalize(data_raw',bounds);

sz = size(data,2);
index = randperm(sz);
cuts = 3;
cut = ceil(sz*(cuts-1)/cuts);

train_x = data(:,index(1:cut));
test_x  = data(:,index(cut+1:end));

%%  Initialize network

isBias1     = 1;
isBias2     = 1;
isTied      = 0;
func1       = func;%'sigm';
func2       = func;%'sigm';
seed        = 906706468;
hid         = 3;
dim         = size(train_x,1);
iter        = 100;
rate        = 0.2;
momentum    = 0.0;
decay       = 0.0;
batch       = 100;
dataset     = file_data;
isVerbose   = 1;

%%  Train network

model = AE_construct( isBias1, isBias2, isTied, func1, func2, ...
        seed, hid, dim, iter, rate, momentum, decay, batch, dataset);
model = AE_init( model, dim );
model = AE_train( model, train_x, test_x, isVerbose);

%%  Get Results

[ e, ev, h, o ] = AE_feedforward( train_x, train_x ,model);

rec = o';

%%  Plot Results

f_error = plot_error(model);

f_alpha = figure('name','encoder alpha change');
plot(model.alpha_change);

f_beta = figure('name','decoder beta change');
plot(model.beta_change);

f_gamma = figure('name','decoder gamma bias change');
plot(model.gamma_change);

f_bias_move = figure('name','decoder bias movement');
plot(model.bias_dist_movement);

f_err_comp_train = figure('name','error components train');
plot(model.err_vec_train);

f_err_comp_test = figure('name','error components test');
plot(model.err_vec_test);

f_rec = figure('name','reconstruction');
scatter(rec(1,:),rec(2,:));

f_activationn = histograms( h,'activations' );

isSep = false;  % Draw each iteration in different frame
isAnim = false;  % Draw all frames (iterations)
f_err_surf = plot_error_surface_2D( model, train_x, isSep, isAnim );

% moves = 100;
% isAnim = false;  % Draw all frames (iterations)
% [ result ] = AE_generate( data, model, moves );
% f_morph = plot_morph( result, isAnim, moves )

f_cent = plot_centroids2(train_x, model,bounds);

f_err_color = plot_error_color(train_x,rec);

isAnim = false;
[distances, f_weight_rel] = weight_relations(model, isAnim);

% f_weight_rel_hist = figure('name','Distances between decoder and encoder weights');
% hist(distances(end,:),20);

fprintf('***** Errors (iteration %d):\n',model.p_iter);
fprintf('  Train error:\t%f\n',model.err_train(end,1));
fprintf('  Test  error: \t%f\n',model.err_test(end,1));
fprintf('  NULL  error: \t%f\n',model.err_null(end,1));

show_hamming(model,data,variation);