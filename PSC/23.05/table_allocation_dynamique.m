function T_alloc = table_allocation_dynamique(table_SNR, nombre_canaux)

T_alloc = [];

%table_SNR = [0 0.5 2 2.1 3 8 9.5 4.2 1.6 5.6 4.2 1.2 1.3 3.5 9.5 4.2 5.3 6.2 1.2 2.3 0 3 6.2 2.3 2.5];
length(table_SNR);
bits_symb = 0; 
table_SNR


for j=1:25
    
    %bits_symb = exp(1 + table_SNR(j));
    
    %T_alloc(j) = floor(bits_symb); 
     if (table_SNR(j)>0) && (table_SNR(j)<0.3)
        bits_symb = 1;
    end
    if (table_SNR(j)>=0.3) && (table_SNR(j)<0.6)
        bits_symb = 2; 
    end
    if (table_SNR(j)>=0.6) && (table_SNR(j)<0.9)
        bits_symb = 3;
    end    
    if (table_SNR(j)>=0.9) && (table_SNR(j)<1.2)
        bits_symb = 4;
    end
    if (table_SNR(j)>=1.2) && (table_SNR(j)<1.5)
        bits_symb = 5;
    end
    if (table_SNR(j)>=1.5) && (table_SNR(j)<1.8)
        bits_symb = 6; 
    end        
    if (table_SNR(j)>=1.8) && (table_SNR(j)<2.1)
        bits_symb = 7;
    end
    if (table_SNR(j)>=2.1) 
        bits_symb = 8; 
    end     
    
    T_alloc(j) = bits_symb; 
end

T_alloc;



    %for i=1:nombre_canaux
    %    if table_SNR(i)~=0
    %        T_alloc(i)=log2(1+table_SNR(i))+1;
    %    else 
    %        T_alloc(i)=1;
    %    end
   % end
%T_alloc
%end