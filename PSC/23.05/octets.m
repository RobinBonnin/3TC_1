function nouvelle_table = octets(tableau_allocation)

tableau_allocation = [2 6 7 8 3 3 1 2 3 5 6 4 2 5 1 4 2 7 5 8 4 5 1 2 4]
Somme = sum(tableau_allocation);

rap = Somme/16;
part_ent = floor(rap);
nombre_bas = Somme-(16*part_ent);
i = 1;
j = 1;

if nombre_bas >= 8
    while j <= 16-nombre_bas
        if tableau_allocation(i) == 8
            i = i + 1; 
        else     
            tableau_allocation(i) = tableau_allocation(i)+1;
            i=i+1;
            j=j+1;
        end    
    end
end  

if nombre_bas < 8
    while j <= nombre_bas
        if tableau_allocation(i) == 1
            i=i+1;
        else    
            tableau_allocation(i) = tableau_allocation(i)-1;
            i=i+1;
            j=j+1;
        end
    end
end

nouvelle_table = tableau_allocation;
s = sum(nouvelle_table);

end