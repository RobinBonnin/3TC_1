function next_tps=next(nombre_canaux)

nombre_canaux = 5;
N=24;                                   %Nombre de crosstalk perturbatrices
f0=1000000;                              %Hz
xn=0.882*(10^-14)*(N^0.6);
f=[4312.5*nombre_canaux];

Knx=zeros(1,nombre_canaux);
DSP_disturber=zeros(1,nombre_canaux);
DSP_next=zeros(1,nombre_canaux);

sinuscard=sinc((pi.*f)./f0);

DSP_disturber=Knx * (sinuscard^2);
DSP_next=DSP_disturber*xn*(f^1.5);

next_tps=ifft(DSP_next);

end

            
            
        
