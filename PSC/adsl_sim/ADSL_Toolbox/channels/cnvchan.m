
% load channel data 


for ii=1:8
channelName= [ 'csaloop', num2str(ii)];
channelTime = ['load csaloop',num2str(ii),'.time'];
eval(channelTime)
%load csaloop1.time;

% put channel data into h and time axis into t
%string = ['t = ',channelName,'(:,1); h = ',channelName,'(:,2);'];
%eval(string)
cmd = [ 't = ', channelName, '(:,1); h= ', channelName, '(:,2);'];
eval(cmd);
%t=csaloop1(:,1); h=csaloop1(:,2);

% sampling frequency
fsample = 2.208e6;
% normalization is required due to the way channel data is stored
h1 = h/2.208e6;
h1 = [h1 ;zeros(2048,1)];
% POTS splitter
[b a] = cheby1(5,1,4.8e3/fsample,'high'); %a=1; b =1;
% channel with splitter
h = filter(b,a,h1);
%h = decimate(h,5);
N=512;
h = h(1:N);

savecmd = ['save csaloop', num2str(ii) , ' h'];
eval(savecmd);
%save csaloop1 h
end

clear all