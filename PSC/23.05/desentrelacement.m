function supertrame_desentrelacee = desentrelacement(supertrame, tab)


supertrame;
T=sum(tab);
Moit = floor(sum(tab)/2);
buf = [;];
A = length(supertrame');

for j=1:68
    for i=1:A
        buf(j,i) = supertrame(j,i);
    end
end

for i=1:(Moit-8)
    for j=1:68
        aligne(((i-1)*68)+j) = buf(j,i);
    end
end
super = [];
for j=1:(Moit-8)
    for i=1:68
        super(i,j) = aligne(i + (j-1)*68);
    end
end
supertrame_desentrelacee = super;

end