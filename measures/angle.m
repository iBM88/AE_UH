function [ theta ] = angle( v1, v2 )
%   Return andle in degrees
    costheta = dot(v1,v2)/(norm(v1)*norm(v2));
    theta = acos(costheta)*180/pi;
    theta(isnan(theta)) = 0 ;
end

