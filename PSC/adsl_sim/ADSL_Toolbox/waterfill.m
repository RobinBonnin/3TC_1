function [y,b] = waterfill(rimpch,noise,totalenergy)

%   waterfill : Water Filling Algorithm.
%   y : Energies per channel Vector.
%   b : Bits per channel
%   rimpch : Channel Impulsive response vector.
%   noise : Noise per channel vector.
%   totalenergy : total available power.
%
%   If the information available is the normalized signal to noise per channel 
%   vector it should be use as rimpch and assing the value 1 to noise.
%
%   Based on John Cioffi development.

gunsortinv=noise./rimpch;
j=length(rimpch);
[d,index]=sort(gunsortinv);                          
i=1;
gsortinv=zeros(1,j+1);
gsortinv(1:j)=d(1:j);
gsortinv(j+1)=totalenergy;
ka=totalenergy+gsortinv(i);
k=ka;
while (k-(gsortinv(i))>0)
    i=i+1;
    ka=ka+gsortinv(i);
    k=ka/i;
end
ka=ka-gsortinv(i);
k=ka/(i-1);
energy=zeros(1,j);
for m=1:(i-1)
    energy(m)=k-gsortinv(m);
    m=m+1;
end
energy2=zeros(1,j);
for m=1:j
    energy2(index(m))=energy(m);
    m=m+1;
end
b=0.50.*(1/log(2)).*log(1+(energy2./gunsortinv));
y=energy2;  

