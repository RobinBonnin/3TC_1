%MBR Maximum bit rate TEQ design.
% [W, D, Dv] = mbr_adv(Sx, Sn, H, N, Nb, Nw, Dmin, Dmax, Wo, G,....., I) returns  
% the optimal time domain equalizer W, and delay D. Optimal is in the 
% sense of maximum channel capacity. Dv is a vector containing the
% objective value for delays between Dmin and Dmax. I is a scalar
% which is multiplied with Nw to determine the number of iteration to 
% be run for the optimization.
%
% Sx is the transmitted signal power spectrum. Sn is the channel noise
% power spectrum. H is the channel impulse response. N is the FFT size
% in the discrete multitone modulation. Nb is the target length of the
% equalized channel. Nw is the number of taps in the time domain 
% equalizer. Dmin and Dmax define the interval over which the delay is
% being searched. Wo is the initial starting point for the optimization.
% G is the SNR gap (not in dB). I is the number of iteration to be
% used in the optimization procedure.
%
% The algorithm is from:
% G. Arslan, B. L. Evans, and S. Kiaei, "Equalization for 
% Discrete Multitone Transceivers to Maximize Channel Capacity", 
% IEEE Trans. on Signal Proc., submitted.



function [wopt,dopt,Dv,exitstatus]=mbr_adv(Sx,Sn,used,h,N,Nb,Nw,Dmin,Dmax,wsub,gamma,codingGain,margin,iter,bf)

% open a figure for progress bar
if bf == 1
   [figHndl statusHndl] = setprogbar('Calculating MBR TEQ ...');     
end

exitstatus = 0;

% initialize variables
bdmtopt = 0;
RES = inf;
fs = 2.208e6;
%opt = foptions; 
%opt(7) =  1;
opt = optimset('fminsearch');
opt.MaxFunEvals = Nw*iter*2;
opt.MaxIter = Nw*iter*2;
%opt.TolX = 1e-20;
%opt.TolFun = 1e-20;

Dv = ones(1,Dmax);
dopt = Dmin;
wopt = wsub;
Dv = 1;
% number of used subchannels
NN = length(Sx);
% channel convolution matrix
H = convmtx(h(:),Nw); 
% first N rows are used
H = H(1:N,:);     
% generate a DFT matrix
[n k] = meshgrid(0:N-1,0:N-1);
QQ = exp(-j*2*pi.*k.*n./N);
% select the rows corresponding to used subchannels
Q = QQ(used,:);

for delay = Dmin:Dmax % for each delay to be searched
  % update progress bar
  if bf == 1
     updateprogbar(statusHndl,delay-Dmin+1,Dmax-Dmin);
  end
  % window function placed at delay+1
  g = zeros(N,1);
  g(delay+1:delay+Nb) = ones(Nb,1); 
  % diagonal signal window matrix
  G = diag(g);
  % diagonal ISI window matrix
  D =  diag(1-g);
  
  for i = 1:NN; % for each used subchannel
	% part of the signal matrix
	X = Q(i,:)*G*H;
	% part of the ISI matrix
	Y = Q(i,:)*D*H;
	% signal matrix for subchannel i
	A(:,:,i) = (X'*X)*Sx(i);
	% distortion matrix for subchannel i
	B(:,:,i) = (Y'*Y*Sx(i) + Q(i,1:Nw)'*Q(i,1:Nw)*Sn(i));

  end
  
%RES = obj(wsub,NN,A,B,gamma);
 RES = obje(wsub,h,delay,Nb,N,Sx,Sn,codingGain,margin,fs,used);


  % turn off annoying warnings during optimization 
  %warning off; 
  % minimize the objective 
  %wo = fmins('obj',wsub,opt,[],NN,A,B,gamma); 
 %  wo = fmins('obje',wsub,opt,[],h,delay,Nb,N,Sx,Sn,codingGain,margin,fs,used); 

% save 'temp1'
 
% wo = fmins('obje',wsub,opt,h,delay,Nb,N,Sx,Sn,codingGain,margin,fs,used);

[wo,fval,exitflag,output] = fminsearch(@(w) obje(w,h,delay,Nb,N,Sx,Sn,codingGain,margin,fs,used), wsub, opt);

if exitflag ~= 1
    exitstatus = -1;
%     warning('Optimalization NOT converged !!!')
end

  wo = wo/norm(wo);
  % turn warning back on
  %warning on;
  % calculate the objective (-bdmt) for the obtained TEQ
  %res = obj(wo,NN,A,B,gamma);
  res = obje(wo,h,delay,Nb,N,Sx,Sn,codingGain,margin,fs,used);

  % save the objective for the current delay
  Dv(1,delay) = res;

  if res < RES % if objective is smaller than previous ones
	% save the current TEQ, delay, and objective
	wopt = wo;
	dopt = delay;
   RES = res;
end
 end
 
    
 % close progress bar
 if bf == 1
    close(figHndl);
 end
 