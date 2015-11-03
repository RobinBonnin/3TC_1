function suite_bits_in = gene_bits(N, p0 )

% Cette fonction gene_bits permet de générer une suite binaire aléatoire de
% longueur N

% p0 est la probabilité d'avoir un 0 (Nous avons p0=0.5 ssi cas
% équiprobable).
% N représente la longueur de la suite.
for i=1:N
suite_ini(i)=sign(rand-p0);

if(suite_ini(i)==-1)
    suite_ini(i)=0;
end
% disp( sprintf( '%d', suite_ini(i)));
end
suite_bits_in=suite_ini; %Affiche la suite binaire en ligne
end

