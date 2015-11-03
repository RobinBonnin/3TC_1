
%5eme ordre Cheby1 LP �  wc = 0.1* freq. Nyquist : filtre 1
% <=> wc= 0.05 en freq normalis� par rapport � Fe...
b6=[0.000010244489966, 0.00005122244983, 0.00010244489966, 0.00010244489966, 0.00005122244983, 0.000010244489966];
a6=[1, -4.587872303018951, 8.539921345676827, -8.056010065267944, 3.849456261673001, -0.745167415384022];

%% filtre � synth�tiser avec pb de precision...  filtre 2
%10eme ordre  Butterworth LP � wc =0.1 * freq. Nyquist 
% <=> wc= 0.05 en freq normalis� par rapport � Fe...
% Pb � l'export des coeff precision pas assez bonne , la reponse
% frequentielle ne correspond plus a celle de la matrice SOS
% => pr�cision trop faible dans ce format...
b11= 1.0e-006 *[0.0036, 0.0362 , 0.1629, 0.4344, 0.7601, 0.9122 ,0.7601, 0.4344, 0.1629 , 0.0362 , 0.0036];
a11= [1, -7.9923, 28.9122, -62.3154, 88.5877, -86.7671, 59.281, -27.8903, 8.6457, -1.5942, 0.1328];
% avec export dans un fichier Header C=> Pr�cision double flottant, OK
b12 = [ 3.619695077616e-009,3.619695077616e-008,1.628862784927e-007,4.343634093139e-007, 7.601359662994e-007,9.121631595592e-007,7.601359662994e-007,4.343634093139e-007,1.628862784927e-007,3.619695077616e-008,3.619695077616e-009]
a12 = [ 1,-7.992296662399,28.91219458418, -62.31535228155, 88.58766325126,-86.76706804056,59.2809515741,-27.89029917249,8.645682137526,-1.59423976769,0.1327680841929] 
%a=a11;    % initialisation des coeff IIR
%b=b11;
figure(1)
freqz(b,a);

