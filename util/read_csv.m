function [ result ] = read_csv( file )
%   Reads csv data to structure

    fid = fopen(file);
    result = {};
    data = fread(fid, '*char')';

    row = regexp(data, '\n', 'split');

    for i = 1:size(row,2)
        entries = regexp(row(1,i), ',', 'split');
        result{i} = entries;
    end

    fclose(fid);

end

