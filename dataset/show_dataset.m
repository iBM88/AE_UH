clc;
clear all;
close all;

folder_data     = '/data/';
file_data       = 'dataset10.mat';

file = fullfile(pwd, folder_data, file_data);
load(file);

dim = size(data_raw,2);
samples = size(data_raw,1);

figure('name','dataset');
switch dim
    case 1
        hist(data_raw,100);
    case 2
        scatter(data_raw(:,1),data_raw(:,2));
    case 3
        scatter3(data_raw(:,1),data_raw(:,2),data_raw(:,3));
    case 4
        fprintf('unable to plot dataset of size greater than 3D.')
end