function suite_symb=gene_symb(suite_bits,vect_alloc)

% La fonction gene_symb g�n�re les coordonn�es complexes des symboles � partir de la
% suite de bits entr�e en param�tre, ainsi qu'en fonction du vecteur d'attribution 
% des bits sur les differents canaux.
% On r�cup�re finalement la suite des coordonn�es complexes des symboles
% modul�s.

% suite_bits est la suite de bits en entr�e du modulateur.
% vect_alloc est le vecteur d'allocation des bits.


%%%%%%%%%%%%%%
% Modulation %
%%%%%%%%%%%%%%

for i=1:length(vect_alloc)
    
    k_i=vect_alloc(i); % Rappelons que la i-�me composante de vect_alloc 
                       % contient le k_i r�f�rant � la M_i-QAM qui sera utilis�
                       % sur le i-�me canal M_i=2^k_i 
    M_i=2^k_i; % Le nombre de points dans la constellation QAM utilis�e
    
    pond=2.^[(k_i-1):-1:0]; % Poids binaires
    symb_i=suite_bits(1:k_i)*pond'; % On associe un num�ro de symbole � la sous-suite
                                    % de bits trait�e dans la constellation associ�e
    suite_bits=suite_bits(k_i+1:length(suite_bits)); % On enl�ve les bits qui viennent d'�tre trait�s

    [Xi,Xq]=mapQAM(symb_i,M_i); % On calcule les coordonn�es du symbole dans la constellation
    suite_symb(i)=Xi+j*Xq; % Coordonn�es complexes du symbole
    
end