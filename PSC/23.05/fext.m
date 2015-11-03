function fext_temp=fext(H)
N=24;                                           %Nombre de crosstalk perturbatrices
d=1000;
%Constantes frequentielles et bande de frequence utilisee
f=1:25;
f=f*42500;

f0=2208000;                                     %Hz
f3db1=1104000;                                  %Hz
f3db2=20000;                                    %Hz
Kasdl=0.1104;                                   %W
k=9*(10^-20)*((N/49)^0.6);

Hlpf_carre=1./(1+(f./f3db1).^8);
Hhpf_carre=(f.^8)./((f.^8)+(f3db2)^8);


DSPdist=(Kasdl*(2/f0)).*(sinc(pi*f/f0).^2).*Hlpf_carre.*Hhpf_carre;
DSPfext=(k*d).*(H.^2).*(f.^2).*DSPdist;

%fext_sym= [DSPfext,0,fliplr(conj(DSPfext))];

fext_temp=real(ifft(DSPfext))*10^6;
figure(4);
plot(fext_temp);

