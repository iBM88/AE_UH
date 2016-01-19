function [ code ] = map2code( data )
%map2code Converts a matrix to generating code
%   Detailed explanation goes here

    is = ''; js = '';c = 0;
    for i=1:size(data,1)
        for j=1:size(data,2)
            if(data(i,j)==1)
                c=c+1;
                is=strcat(is,',',num2str(i));
                js=strcat(js,',',num2str(j));
            end
        end
    end
    code = strcat('sparse([',is,'],[',js,'],ones(1,',num2str(c),'),',num2str(size(data,1)),',',num2str(size(data,1)),')');
    clipboard('copy', code)
    display code;
end

