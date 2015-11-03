function RS_decode = decode_du_RS(data, tab)
%UNTITLED4 Summary of this function goes here
%  Pour tester : 
    %- RS=testRSOUE(gene_bits(123,0.5),tab)
    % On peut modifier RS avec RS(x)= 0 ou 1 
    % On test décode avec decode_RS(RS)
tab = [4 5 3 6 7 5 2 1 8 7 4 5 3 6 7 5 2 1 8 7 8 4 2 2 5 3 6 2 8 2 6 3 5 4 4];

T = sum(tab); 
t_data = (T/2)-24;
nbr_entiers = ((T/2)/8)-1;
data = gene_bits(t_data, 0.5);

    
for i=0:(nbr_entiers-3)
    mem = data((1 + i*8):((i+1)*8));
    ent = bi2de(mem);
    a_decoder = [a_decoder ent];
end    
    
Somme = 0;
nom = nbr_entiers; 

while nom>=1
    nom = nom/2;
    Somme = Somme+1;
end
Somme = Somme-1

n = (2^Somme)-1
k = n-2;
msg = gf(a_decoder, 8); 

% Problèmes : 
    % Le code RS génère les 4 dernières valeurs qui ne sont pas des octets
    % On ne peut corriger que 2 valeurs, à partir de 3 le décode ne corrige
    % pas
[RS_decode, cnumerr]=rsdec(msg, n, k);
cnumerr
end

