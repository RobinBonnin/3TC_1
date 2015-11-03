function supertrame_codee = RS_encode(data, tab)

tab = [4 5 3 6 7 5 2 1 8 7 4 5 3 6 7 5 2 1 8 7 8 4 2 2 5 3 6 2 7 1 8];
t_data = (sum(tab)/2)-24;
data = gene_bits(t_data, 0.5);
T = sum(tab);
nbr_entiers = ((T/2)/8)-1;

mem = []; 
a_coder = []; 

for i=0:(nbr_entiers-3)
    mem = data((1 + i*8):((i+1)*8));
    ent = bi2de(mem);
    a_coder = [a_coder ent];
end
a_coder

Somme = 0;
nom = nbr_entiers; 

while nom>=1
    nom = nom/2;
    Somme = Somme+1;
end
Somme = Somme-1; 

n = (2^Somme)-1;
k = n-2;
    
msg = gf(a_coder(1:k), 8); 
code = rsenc(msg, n, k);
code = code.x;


L = n+1

for i=L:nbr_entiers
    code(i)=0;
end
code
supertrame_codee = [];
for i=1:(length(code))
    supertrame_codee = [supertrame_codee dec2bin(code(i), 8)];
end 
