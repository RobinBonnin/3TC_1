function    [rxsig, chan] = tx_rx_chan(txsig, loop_num, plot_chan)

 if nargin ~= 3
     error('need all 3 inputs')
     return;
 end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set path for channel files 
addpath('channels')
% load channel data 

%load channels/csaloopxx;
cmd=[ 'load channels/csaloop' num2str(loop_num) '.mat'];
eval(cmd);
N=512;

 rxsig=conv(h,txsig);
 rxsig=rxsig(1:end-N+1);
 
 if plot_chan == 1
 
     figure;
         subplot(211);
         plot(txsig);
         title('channel : TX sig');
         axis([0 length(txsig) 1.2*min(txsig) 1.2*max(txsig)])
         subplot(212);
         plot(rxsig);
         title('channel : RX sig');
         axis([0 length(txsig) 1.2*min(txsig) 1.2*max(txsig)])
 end
 chan =h;
 return
