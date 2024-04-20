function [F,Pxx] = psd_(t,ts,fd)
%ts: time series.
%t: time vector.
if size(ts,1)~=1
    ts=ts';
end

ts=ts-mean(ts);
ts=ts.*hanning(length(ts))';

%% DFT
dt=(t(2)-t(1));
fs=1/dt;

if (nargin>2)

    m=floor(0.5*fs/fd);
    lenC=floor(length(ts)/m);
    
    tn=t(1:m:end);
    tn=tn(1:lenC);
    dtn=(tn(end)-tn(end-1));
    fsn=1/dtn;
    
    for loop=1:m
        tmpvar=ts(loop:m:end);
       [Px(loop,:),F]=pwelch(tmpvar(1:lenC),[],[],length(tmpvar(1:lenC)),fsn);
    end
    
    if (m>1)
        Pxx=mean(Px);
    else
        Pxx=Px;
    end

else

    [Pxx,F]=pwelch(ts,[],[],length(ts),fs);

end
Pxx = pow2db(Pxx);
if size(Pxx,1)~=1
    Pxx=Pxx';
end
if size(F,1)~=1
    F=F';
end
% grid on
% axis tight
end