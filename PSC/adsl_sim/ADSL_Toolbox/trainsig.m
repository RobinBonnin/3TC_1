%TRAINSIG Modulates binary data with discrete multitone modulation.
% Y = TRAINSIG(X,L,F,P) returns a DMT training signal in Y. 
%
% X is length-N binary input sequence to be modulated where N is the FFT
% size in the DMT modulation. L*N is the length of Y. F is a flag if set 
% to 1 then Y is periodic with N. P defines the number of unused 
% subchannels near DC.


function [y, Fx] = trainsig(x,L,flag,P)
x = x(:).'; 
N = length(x);

if flag == 0
   x = x(1:N-1);
   x1 = kron(ones(1,L),x);
   x15 = [x1 x1(1:L)];
   x2 = reshape(x15,2,L*N/2);
else 
   x1 = reshape(x,2,N/2);
   x2 = kron(ones(1,L),x1);
end

x3 = -2*(x2 - 0.5);
x4 = x3(1,:)+j*x3(2,:);
x5 = reshape(x4,N/2,L).';
x5(:,1:P) = zeros(L,P);
x6 = [zeros(L,1) x5(:,2:N/2) zeros(L,1) fliplr(conj(x5(:,2:N/2))) ].';
x7 = real(1/sqrt(N)*ifft(x6));  %%why 1/sqrt(N) not sqrt(N)
x8 = reshape(x7,1,N*L);
y = x8;
Fx = x6;


