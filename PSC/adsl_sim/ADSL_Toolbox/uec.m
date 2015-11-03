%UEC Minimum mean-squared error time domain equalizer design 
%    using the unit-energy constraint.
% [B, W, D, MSE, Dv] = UEC(X, Y, N, Nb, Nw, Dmin, Dmax) returns
% the optimal target impulse response B, the time domain equalizer
% W, and the delay D. Optimal is in the sense of minimum mean-squared
% error under the unit-energy constraint. MSE is the resulting 
% mean-squared error and Dv is a vector containing the mean-squared 
% error for delay values between Dmin and Dmax.
%
% X is the transmitted data vector. Y is the received data vector
% (without channel noise). N is the channel noise vector. Nb is the 
% number of taps in the target impulse response and Nw the number of 
% taps in the time domain equalizer. Dmin and Dmax define the search 
% interval for the optimal delay.
% 
% See also UTC, EIGEN, CORRELATIONS
%
% The algorithm is from:
% N. Al-Dhahir and J. M. Cioffi, "Efficiently Computed Reduced-Parameter 
% Input-Aided MMSE Equalizers for ML Detection: A Unified Approach", 
% IEEE Trans. on Info. Theory, vol. 42, pp. 903-915, May 1996.



function [bopt, wopt, dopt, MSE, delayVec]=uec(x,y,Nb,Nw,minDelay,maxDelay,bf)

% calculate the input-output auto and cross correlations
[Rxx,Ryy,rxy,L] = correlations(x,y,maxDelay,Nb,Nw);

% solve the eigenvalue problem
[bopt, wopt, dopt, MSE, Rxyopt, delayVec] = ...
	eigen(Rxx,Ryy,rxy,minDelay,maxDelay,Nb,Nw,L,0,bf); 





