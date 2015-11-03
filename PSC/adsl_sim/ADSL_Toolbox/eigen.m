%EIGEN Solves the eigenvalue problem in design of the unit-energy 
%      constrained  minimum mean-squared error time domain equalizer.
% [B, W, D, MSE, R, Dv] = EIGEN(RXX, RYY, RXY, Dmin, Dmax, Nb, Nw, L) 
% returns the optimal target impulse response B, the time domain 
% equalizer W, and the delay D. Optimal is in the sense of minimum 
% mean-squared error under the unit-energy constraint. MSE is the 
% resulting mean-squared error. R is the input-output cross-correlation
% matrix obtained with the the optimum delay D, and Dv is a vector 
% containing the mean-squared error for delay values between Dmin and 
% Dmax.
%
% RXX is the input autocorrelation matrix. RYY is the output 
% autocorrelation matrix. RXY is the input-output cross-correlation
% vector used to generate the input-output cross-correlation matrix
% depending on the current delay. Dmin and Dmax define the search 
% interval for the optimal delay. Nb is the number of taps in the target 
% impulse response and Nw the number of taps in the time domain equalizer. 

% The algorithm is from:
% N Al-Dhahir and J. M. Cioffi, "Efficiently Computed Reduced-Parameter 
% Input-Aided MMSE Equalizers for ML Detection: A Unified Approach", 
% IEEE Trans. on Info. Theory, vol. 42, pp. 903-915, May 1996.



function [b, w, d, MSE, Rxyopt, Dv] = ...
	eigen(Rxx,Ryy,rxy,Dmin,Dmax,Nb,Nw,L,statusHndl,bf) 

% initialize variables
delayVec = ones(1,Dmax);
VAL = 0;
MSE = inf;

% open a figure for progress bar
if Dmax ~= Dmin & bf == 1
  [figHndl statusHndl] = setprogbar('Computing ...');     
end

for delay = Dmin:Dmax; % for each delay to be searched
   
  % update progress bar
  if Dmax ~= Dmin & bf == 1
	updateprogbar(statusHndl,delay-Dmin+1,Dmax-Dmin);
  end
  % calculate the input-output cross-correlation matrix
  Rxy = toeplitz(rxy(L+(0:Nb-1)+delay+1),rxy(L-(0:Nw-1)+delay+1));
  % calculate the MSE matrix
  Rd = Rxx - Rxy*inv(Ryy)*Rxy';
  % find the eigenvector corresponding to the minimum eigenvalue
  [mse bb] = mineig(Rd); 
  % save the MSE for this delay
  Dv(delay) = mse;
  
  if mse < MSE % if the current MSE is lower then previous ones
	% save the current target, delay, MSE, and crosscorrelation matrix
	b = bb;
	d = delay;
	MSE  = mse;
	Rxyopt = Rxy;
end

end

% use the optimum target impulse response to find the optimum TEQ
w = inv(Ryy)*Rxyopt'*b;

% close progress bar
if Dmax ~= Dmin & bf == 1
  close(figHndl);
end
