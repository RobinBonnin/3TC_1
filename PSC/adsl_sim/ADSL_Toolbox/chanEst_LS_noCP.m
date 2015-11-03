function [chanEst] = chanEst_LS_noCP( inp_sig, d_code1, Nfft, No_symbols)

% [chanEst] = chanEst_LS( inp_sig, d_code1, Nfft, No_symbols)
%
% inputs:
%   inp_sig is the input continuous time signal and d_code1 is the known
%   long training sequence
%   Nfft: fft size
%   No_symbols: number of symbols in input sequence
%
% Outputs: 
%   chanEst is the LS H_estimated after correlation (using properties of inverse complex number).
chan=zeros(size(d_code1));
inp_sig = reshape(inp_sig,length(inp_sig),1); % to be sure that inp_sig is a column vector
inp_sig2 = reshape(inp_sig,Nfft,No_symbols); %each column is a one training symbol

input_f=fft(inp_sig2); % demodulates the training symbols

index=find(d_code1);
d_code=d_code1(index); % d_code contains only used subcarriers
input=input_f(index,:); %input contains only corresponding not zero subcarriers


lcode0=length(d_code);


x_uu = input.*conj(input); %autocovariance
X_uu = sum(x_uu.').';

dcode_m=reshape(d_code,prod(size(d_code)),1)*ones(1,No_symbols);

x_uy = input.*conj(dcode_m); % cross correlation 
X_uy = sum(x_uy.').'; 


chan_tmp= conj(X_uu./X_uy);
chan(index)=chan_tmp;

chanEst=chan(1:end/2).';
