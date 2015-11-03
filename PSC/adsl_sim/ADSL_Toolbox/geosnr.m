%GEOSNR Geometric SNR, bit per symbol, and bit rate.
% [G, B, R] = GEOSNR(SNR, M, C, N, Nb, Fs) returns the geometric
% SNR in G (dB), bit per symbol in B, and bit rate in R.
%
% SNR is a vector containing the SNRs in each used subchannel.
% M is the system margin in dB. C is the coding gain of any code
% applied in dB. N is the FFT size in the discrete multitone 
% modulation. Nb is the cyclic prefix length. Fs is the sampling
% frequency.



function [SNRgeo, bDMT, RDMT] = geosnr(SNRi,margin,codingGain,N,Nb,fs)

% calculate gamma
gam = 10^((9.8 + margin - codingGain)/10);
% number of channels used
NN = length(SNRi);
% geometric SNR
SNRgeo  = 10*log10( gam*(prod( (1+(SNRi/gam)).^(1/NN))-1) );
% bits/symbol
bDMT = (NN*log(  (1+(( 10^(SNRgeo/10))/gam)) )  /log(2));

%bDMT = sum(log(1+SNRi/gam)/log(2));
% bits/second
RDMT = sum(log(SNRi/gam+1)./log(2))*fs/(N+Nb);
%RDMT = fs./(N+Nb)*(log(SNRgeo/gam+1)./log(2))*NN
%RDMT = bDMT/(N+Nb)*fs

