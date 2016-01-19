%%  Delet tests
%   Behrang Mehrparvar
%   behrang.mehrparvar@gmail.com

%   This code just deletes all test experiments and data

close all;
clear all;

folders = {'/test_data/','/test_results/','/test_experiments/'};

for i=1:numel(folders)
    path = fullfile(pwd,folders{i});
    if ispc
        cmd = sprintf('del /q\t%s*',path);
    elseif isunix
        cmd = sprintf('rm -rf\t%s*',path);
    else
    % do a third thing
    end
    system(cmd);
end