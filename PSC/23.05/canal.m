function signal_recu=canal(signal_module, nombre_canaux, h_eval)

% La fonction canal permet de simuler un canal r�el, int�grant du bruit et de la diaphonie.
% Tous les �chantillons sortant du modulateur DMT traverseront
% ce canal pour finalement �tre envoy�es au d�modulateur.

% x_mod est le vecteur sorti du modulateur DMT.
% h est la r�ponse impulsionnelle en temps du canal.

HH = length(signal_module);

f = 42500;
l = 1000;
d=0.001;
D=0.0015;
sigma=56500000;
nuzero= 4*pi*0.0000001;
epsilonzero= (1/(36*pi))*0.000000001;
epsilonR=2;
epsilon= epsilonR*epsilonzero;
tan=0.5*0.0001;

C = (pi*epsilon)/(log((2*D)/d));
L = (nuzero/pi)*log((2*D)/d);


Hech = [];

for j=1:nombre_canaux
    G = C*2*pi*(f*j)*tan;
    R = sqrt((nuzero*f*j)/(pi*sigma))*(1/(d*sqrt(1-(d/D)^2)));
    gamma = sqrt ((R + 2i*L*pi*(f*j)) .* (G + 2i*C*pi*(f*j)));
    H = -0.5*exp(-gamma * l);
    Hech = [Hech H];
    Yech = fliplr(conj(Hech));
    Y = [0 Hech 0 Yech];  
    h = abs(ifft(Y));
end
Hech = Hech  + fext(h_eval);
figure(2); 
plot(abs(Hech));
figure(6); 
plot(abs(h));

%h=[1 0 0 0 0];
%signal_module = [1 3 4 5 2 2 10 10];

signal_recu_int = conv(signal_module, h);
signal_recu = signal_recu_int(11:(HH+10));
