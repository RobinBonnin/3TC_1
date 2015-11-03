function y = testbruit(x)

%t = 0:.1/10:10;

nb_canaux = 25;
f0= 1;
H=zeros(1,nb_canaux);
%x = 0.000000001;


k=1.3806488*10^(-23);
T=293.15;
B=255*4312.5;
Px = 1;
SNRl = Px/(k*T*B);
SNR = 10*log10(SNRl);

y = awgn(x,SNR) % Add white Gaussian noise.
%plot(t,x, t,y) % Plot both signals.
%legend('Original signal','Signal with AWGN');

end

