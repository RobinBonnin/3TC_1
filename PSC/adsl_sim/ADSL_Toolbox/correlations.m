%CORRELATIONS Input/output auto/cross-correlation.
% [RXX, RYY, RXY, L] = CORRELATIONS(X,Y,Dmax,Nb,Nw) returns the 
% input autocorrelation matrix RXX, the output autocorrelation 
% matrix RYY, and the input-output cross-correlation vector RXY 
% of size 2L+1. L is calculated so that the cross-correlation 
% matrix of a delayed X and Y can be generated from RXY. The delay 
% of X has to be smaller than Dmax.
%
% X is the transmitted data vector. Y is the received data vector
% (including the channel noise). Dmax is the maximum allowed delay.
% Nb and Nw are the tap sizes of the target impulse response and
% the time domain equalizer, respectively.

function [Rxx,Ryy,rxy,L] = correlations(x,y,maxDelay,Nb,Nw)

% size of rxy should be big enough to generate cross
% correlation matrices for delays up to maxDelay
L = max([maxDelay+Nb Nw]);
% calculate the input autocorrelation vector of size Nb
rxx = xcorr(x,x,Nb,'unbiased');
% form a toeplitz matrix of size Nb x Nb
Rxx = toeplitz(rxx(Nb+1+(0:Nb-1)));
% calculate the output autocorrelation vector of size Nw
ryy = xcorr(y,y,Nw,'unbiased');
% form a toeplitz matrix of size Nw x Nw
Ryy = toeplitz(ryy(Nw+1+(0:Nw-1)));
% calculate the input-output cross-correlation of size L
rxy = xcorr(x,y,L,'unbiased');
% fix for the bug in Matlab 5.0
% it gives the cross correlation flipped
vers = version;

    rxx = fliplr(rxx);
    rxy = fliplr(rxy);
    ryy = fliplr(ryy);


