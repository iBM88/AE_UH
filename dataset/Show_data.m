function Show_data( data, sz )
%Shows all images in a dataste
%   Detailed explanation goes here

    figure('name','raw data');
    for s = 1: size(data,1)
        im = reshape(data(s,:),sz);
        imshow(im);
        shg
    end

end

