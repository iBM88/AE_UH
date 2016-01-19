file = 'D:\behrang\Thesis\Jan2016\test_experiments\experiments.csv';

fid = fopen(file);
status = feof(fid);
result = [];
data = fread(fid, '*char')';

row = regexp(data, '\n', 'split');

for i = 1:size(row,2)
    entries = regexp(row(1,i), ',', 'split');
    result{i} = entries;
end

fclose(fid);

%data = textread(file, '', 'delimiter', ',','emptyvalue', NaN);