function supertrame_codee = codage_RS(donnees, tab)
supertrame_codee=[];    
N=sum(tab)
    m=0;
    while(N>1)
        N=N/2;
        m=m+1;
    end
    n=2^(m-1);
    n=n/2-8
    N=sum(tab);
    %tab = [7 6 3 8 4 4]
    %taille_trame = sum(tab)
    %taille_code_RS = taille_trame-8; 
    %on veut un message de taille 24 
    %donnees = gene_bits(255, 0.5)
    2^(m-1)-1
    k = 8;
    msg = gf(donnees, m-1);
    supertrame_codee = rsenc(msg,2^(m-1)-1,123);
    %code_RS = [];
    
    %%for i=0:2
      %  for j=(k+1):n
       %     code_RS((i*15)+j) = Decod_binaire(code(i,j), m);
       % end
   % end
   % code_RS
end 