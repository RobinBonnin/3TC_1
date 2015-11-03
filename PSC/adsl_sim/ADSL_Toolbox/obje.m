%PERFORM Evaluate the performance of an TEQ in terms of
% SSNR, SNR, geometric SNR, and channel capacity.
% [SS, S, Si, Sg, Mg, Bf, Bm, Rf, Rm, Hw, Fh, Fw, Nc, Fhw] = 
% PERFORM(W,B,H,D,Nb,NN,X,N,Ph,Px,Pn,M,C,Fs,Mi) returns
% the shortening SNR in SS, the SNR at the output of the 
% equalizer in S, the SNR distribution over the subchannels
% in the vector Si. Sg is the real geometric SNR achieved
% with the TEQ and Mg is the geometric SNR that can be 
% achieved in the case of zero ISI (Mg is calculated using
% the MFB distribution while Sg is calculated with the SNR
% distribution.). Bf is the number of bits per symbol 
% achievable with the TEQ and Bm is the upperbound on
% bits per symbol. Rf is the channel capacity achieved with 
% the TEQ and Rm is the upperbound on the channel capacity.
% Hw is a vector containing the equalized channel impulse 
% response. Fh is a vector containing the frequency response 
% of the original channel and Fw is vector containing the 
% equalizer. Nc is a vector of the power spectrum of the 
% channel noise after equalization and Fhw is a vector 
% containing the frequency response of the equalized channel.
%
% W is TEQ impulse response. B is the target impulse response
% (for MMSE based techniques). H is the channel impulse
% response. D is the optimal delay with TEQ. Nb is the target
% window size. NN is the FFT size used in the DMT modulation.
% X is the transmitted signal. N the channel noise. Ph is the 
% magnitude square of the channel frequency response. 
% Px is the power spectrum of the transmitted signal. Pn is the 
% power spectrum of the channel noise. M is the desired system 
% margin in dB which is used for channel capacity calculations.
% C is the coding gain in dB assumed for channel capacity 
% calculations. Fs is the sampling frequency. Mi is the matched
% filter bound distribution over frequency.



function y = obje(W,channel,D,Nb,N,inputSpec,noiseSpec,margin,codingGain,fs,used)
W = W/norm(W);
hw = filter(W,1,channel);
win = zeros(length(hw),1); 
win(D+1:D+Nb) = ones(1,Nb); 
hwin = hw.*win;               
hwout = hw.*(1-win);                    
Fwu = fft(W,N)*sqrt(N); Fw = Fwu(1:N/2+1).';  %Fw = Fw(used);
Fhwinu = fft(hwin,N)*sqrt(N); Fhwin = Fhwinu(1:N/2+1).'; %Fhwin = Fhwin(used);
Fhwoutu = fft(hwout,N)*sqrt(N); Fhwout = Fhwoutu(1:N/2+1).'; %Fhwout = Fhwout(used);
Fhwin = Fhwin(used);
Fhwout = Fhwout(used);
Fw = Fw(used);

colorNoiseaft = noiseSpec.*abs(Fw).^2;  
isiaft = inputSpec.*abs(Fhwout).^2;   
signalaft = inputSpec.*abs(Fhwin).^2;    
SNRi = signalaft./( colorNoiseaft + isiaft );  
[geoSNRfinal bDMTfinal RDMTfinal] = geosnr(SNRi,margin,codingGain,N,Nb,fs);

y = -bDMTfinal;
