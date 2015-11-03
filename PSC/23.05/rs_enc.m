function supertrame_desentrelacee = desentrelacement(supertrame, tab)

T=sum(tab);
Moit = floor(sum(tab)/2);
buf = [;];

for j=1:68
    for (Moit+9):T
        buf(j,i) = supertrame(j,i);
    end
end



end