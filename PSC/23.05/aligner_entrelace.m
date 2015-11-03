function aligne = aligner_entrelace(supertrame, I)

en_ligne = [];
%I = sum(tableau_allocation);

for i=1:I
    for j=1:68
        en_ligne(((i-1)*68)+j) = supertrame(i,j);
    end
end

aligne = en_ligne;
end