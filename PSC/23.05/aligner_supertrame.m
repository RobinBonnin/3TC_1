function supertrame_en_ligne = aligner_supertrame(supertrame, tableau_allocation)

en_ligne = [];
I = sum(tableau_allocation);

for i=1:68 
    for j=1:I
        en_ligne(((i-1)*I)+j) = supertrame(i,j);
    end
end

supertrame_en_ligne = en_ligne;
end
