function data=double_moon(r,w,ts,d)
    clear all; close all;
    if nargin<4, w=6;end
    if nargin<3, r=10;end
    if nargin<2, d=1;end
    if nargin < 1, ts=1000; end
    ts1=10*ts;
    done=0; tmp1=[];
    while ~done,
        tmp=[2*(r+w/2)*(rand(ts1,1)-0.5) (r+w/2)*rand(ts1,1)];
        tmp(:,3)=sqrt(tmp(:,1).*tmp(:,1)+tmp(:,2).*tmp(:,2));
        idx=find([tmp(:,3)>r-w/2] & [tmp(:,3)<r+w/2]);
        tmp1=[tmp1;tmp(idx,1:2)];
        if length(idx)>= ts,
            done=1;
        end
    end
    data=[tmp1(1:ts,:) zeros(ts,1);
        [tmp1(1:ts,1)+r -tmp1(1:ts,2)-d ones(ts,1)]];
    plot(data(1:ts,1),data(1:ts,2),'.r',data(ts+1:end,1),data(ts+1:end,2),'.b');
    title(['Perceptron with the double-moon set at distance d = ' num2str(d)]),
    axis([-r-w/2 2*r+w/2 -r-w/2-d r+w/2])
    %save dm r w ts d data;
end