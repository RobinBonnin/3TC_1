function fext_temp=fext(nombre_canaux,prefixe)

N=24;                                           %Nombre de crosstalk perturbatrices

d=1500/3.2808;                                  % ft (conversion de la valeur des m en ft) 

%Constantes fréquentielles et bande de fréquence utilisée
f=[0:nombre_canaux-1];
f=f*42500;

f0=10000000;                                     %Hz
f3db1=1104000;                                  %Hz
f3db2=20000;                                    %Hz
kfx=0.1104;                                     %W



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
end




Hf=Hech;           %reponse frequentielle du canal
Hf=[Hf zeros(1,prefixe)];
k=9*(10^-20)*((N/49)^0.6);


sinuscard=sinc((pi.*f)./f0);


Hlpf_carre=1./(1+(f./f3db1).^8);
Hhpf_carre=(f.^8)./((f.^8)+(f3db2)^8);

DSPdist=(kfx*(2/f0)).*(sinuscard.^2).*Hlpf_carre.*Hhpf_carre;
DSPfext=(k*d).*(Hf.^2).*(f.^2).*DSPdist;

fext_temp=ifft(DSPfext);
