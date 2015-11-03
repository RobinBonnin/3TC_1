 %MSSNR Maximum shortening signal-to-noise ratio TEQ design.
% [W, D, Dv] = MSSNR(H, Nb, Nw, Dmin, Dmax) returns the optimal
% time domain equalizer, and delay. Optimal in the sense of 
% maximizing the shortening signal to noise ratio. Dv is a vector
% containing the remaining tail power for delay values between
% Dmin and Dmax.
%
% H is the channel impulse response. Nb is the target length
% of the shortened impulse response. Nw is the number of taps
% in the TEQ. Dmin and Dmax define the search interval for the 
% optimal delay.
%
% The algorithm is from:
% P. J. W. Melsa, R. C. Younce, and C. E. Rohrs, "Impulse Response
% Shortening for Discrete Multitone Transceivers", IEEE Trans. on
% Comm., vol. 44, pp. 1662-1672, Dec. 1996.



function [wopt,dopt,delayVec] = mssnr(h,Nb,Nw,Dmin,Dmax,bf)

% open a figure for progress bar
if bf == 1
   [figHndl statusHndl] = setprogbar('Calculating MSSNR TEQ ...');     
end
% initialize variables
h = h(:);
lambdaopt = 0;
delayVec = ones(1,Dmax);
% channel convolution matrix
H = convmtx(h,Nw);

for delay = Dmin:Dmax % for each delay to be searched
   
  % update progress bar
  if bf == 1
     updateprogbar(statusHndl,delay-Dmin+1,Dmax-Dmin);
  end
  % Hwin: inside the window
  Hwin = H(delay+1:delay+Nb,:);
  % Hwall: outside the window
  Hwall = [H(1:delay,:); H(delay+Nb+1:size(H,1),:)];
  % energy of Hwall
  A = transpose(Hwall)*Hwall;
  % energy of Hwin
  B = transpose(Hwin)*Hwin;
  % Cholesky decomposition
  [sqrtA] = chol(A);
  % composite matrix
  C = inv(sqrtA.') * B * inv(sqrtA);
  [lambda q] = maxeig(C);
  w = inv(sqrtA) * q;
  %end
  
  % save the energy of hwall for the current delay
  delayVec(delay) = lambda;

  if lambda > lambdaopt % if energy is smaller than previous ones
     % save the TEQ, delay and energy
     wopt = w;
     dopt = delay;
     lambdaopt = lambda;
  end
end

% close progress bar
if bf == 1
   close(figHndl);
end

