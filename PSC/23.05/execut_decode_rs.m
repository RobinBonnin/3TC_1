function  supertrame_corrigee = execut_decode_rs(supertrame, tab)

mem = [];

%tab = [4 5 3 6 7 5 2 1 8 7 4 5 3 6 7 5 2 1 8 7 8 4 2 2 5 3 6 2 8 2 6 3 5 4 4];

T = sum(tab); 
Moit = floor(T/2);
nbr_entiers = ((T/2)/8)-1;    
    
Somme = 0;
nom = nbr_entiers; 

while nom>=1
    nom = nom/2;
    Somme = Somme+1;
end
Somme = Somme-1;

n = (2^Somme)-1;
k = n-2;

for i=0:67
    for j=9:((n+1)*8)
        memoire(j-8) = supertrame((i*T) +j);
    end
    memoire;
    mem2 = DECRS(memoire, tab);
    for j=9:((k+1)*8)
        supertrame((i*T)+j) = mem2(j-8);
    end
end

%supertrame
%for i=0:67
%    for j=(Moit+9):(Moit+(n+1)*8)
%        memoire(i+1,j-8-Moit) = supertrame((i*T) +j);
%    end
%end
%memoire

%mim = desentrelacement(memoire, tab);
for i=0:67
    for j=(Moit+9):(Moit+(n+1)*8)
        memoire(j-8-Moit) = supertrame((i*T) +j);
    end
    memoire;
    mem2 = DECRS(memoire, tab);
    for j=(Moit+9):(Moit+(k+1)*8)
        supertrame((i*T)+j) = mem2(j-8-Moit);
    end
end
%for i=0:67
%    mem2 = DECRS(mim, tab);
%    for j=(Moit+9):((k+1)*8)
%        supertrame((i*T)+j) = mem2(j-8-Moit);
%    end
%end

supertrame_corrigee = supertrame;

end

