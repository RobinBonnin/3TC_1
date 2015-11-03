%GEO Geometric TEQ design.(x,y,Nb,Nw,N,minDelay,maxDelay,MSEmax,Buec)
% [B, W, D, MSE, Dv] = GEO(X, Y, N, Nb, Nw, NN, Dmin, Dmax, MSEmax, Buec)
% returns the optimal target impulse response B, time domain 
% equalizer W, and delay D. Optimal is in the sense of maximizing
% the approximate geometric SNR. MSE is the resulting mean-squared 
% error. Dv is a vector containing the mean-squared error for delay
% values between Dmin and Dmax.
%
% X is the transmitted data vector. Y is the received data vector
% (without channel noise). N is the channel noise vector. Nb is the 
% number of taps in the target impulse response and Nw the number of 
% taps in the time domain equalizer. NN is the FFT size in the discrete
% multitone modulation. Dmin and Dmax define the search interval for 
% the optimal delay. MSEmax the upperbound on the mean-squared error. 
% Buec is the starting point for the nonlinear constraint optimization
% required to find the optimal TEQ.
%
% NOTE: The Mathworks Optimization Toolbox is required to run this
% function. The 'constr' is used from the Optimization toolbox.
% Optimization Toolbox Version 1.5.1 has been used in this function
%
% The design method is from:
% N. Al-Dhahir and J. M. Cioffi, "Optimum finite-length equalization
% for multicarrier transceivers", IEEE Trans. on Comm., vol 44. 
% pp. 56-63, Jan. 1996.

function [b,w,d,mmse,delayVec,exitstatus]=geo(x,y,Nb,Nw,N,minDelay,maxDelay,MSEmax,Buec,bf,used)

exitstatus = 0;

% initialize variables
MMSE = inf;
VAL = inf;

%%opt = foptions;
%%opt(14) = 200*Nb;
%%%opt(2) = 1e-4;
%%%opt(3) = 1e-4;
opt = optimset('fmincon');
opt = optimset('LargeScale','off');
%opt = optimset(opt,'Display','iter');
opt = optimset(opt,'MaxFunEvals', 2000*Nb);
opt = optimset(opt,'MaxIter', 200*Nb);

binit = Buec;
delayVec = ones(1,maxDelay); 
used = [0 ones(1,N/2-1) 0] == 1;

% calculate the input-output auto and cross correlations
[Rxx,Ryy,rxy,L] = correlations(x,y,maxDelay,Nb,Nw);

% open a figure for progress bar
if bf == 1
[figHndl statusHndl] = setprogbar('Calculating Geometric TEQ ...');     
end


for delay = minDelay:maxDelay % for each delay to be searched
  % update progress bar
  if bf == 1
     updateprogbar(statusHndl,delay-minDelay+1,maxDelay-minDelay);
  end
  % solve the eigenvalue problem (note eigen running just for one delay
  [bopt, wopt, dopt, MSE, Rxy] = eigen(Rxx,Ryy,rxy,delay,delay,Nb,Nw,L);
  % calculate the MSE matrix
  Rd = Rxx - Rxy*inv(Ryy)*Rxy';
  VAL = objective(binit,minDelay,N,Rd,MSE,MSEmax,used);
  % solve the constraint optimization problem with the toolbox

  %%  bo = constr('objective',binit,opt,[],[],[],delay,N,Rd,MSE,MSEmax,used);
  % % constr  Finds the minimum of a constrained multivariable function
  % [x,options,lambda,hess]=constr('function',x0,options,vlb,vub,'grad',p1,p2)

[bo, fval, exitflag, output] = fmincon(@(b) objective(b,delay,N,Rd,MSE,MSEmax,used), binit,[],[],[],[],[],[],... 
   @(b) objectiveconfun(b,Rd,MSEmax), opt)
  
  if exitflag < 0
	exitstatus = -1;
	warning('Optimalization NOT really done ...');
  end
  % calculate the mean-squared error
  mmse = bo'*Rd*bo;
  % get the value of the objective function for the current TIR
  val = objective(bo,delay,N,Rd,MSE,MSEmax,used);
  % save the MSE for this delay
  delayVec(delay) = val;
 
  if (VAL > val) % if the current objective is lower then previous ones
	% save the current target, delay, objective, MSE, and 
	% cross-correlation matrix
	b = bo;
	d = delay;
	VAL = val;
	MMSE = mmse;
	Rxyopt = Rxy;
  end
end

% use the optimum target impulse response to find the optimum TEQ
w = inv(Ryy)*Rxyopt'*b;
 
% close progress bar
if bf == 1
   close(figHndl);
end

