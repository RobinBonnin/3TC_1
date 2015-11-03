function suite_symb=gene_symb(suite_bits,vect_alloc)

% La fonction gene_symb génère les coordonnées complexes des symboles à partir de la
% suite de bits entrée en paramètre, ainsi qu'en fonction du vecteur d'attribution 
% des bits sur les differents canaux.
% On récupère finalement la suite des coordonnées complexes des symboles
% modulés.

% suite_bits est la suite de bits en entrée du modulateur.
% vect_alloc est le vecteur d'allocation des bits.


%%%%%%%%%%%%%%
% Modulation %
%%%%%%%%%%%%%%

for i=1:length(vect_alloc)
    
    k_i=vect_alloc(i); % Rappelons que la i-ème composante de vect_alloc 
                       % contient le k_i référant à la M_i-QAM qui sera utilisé
                       % sur le i-ème canal M_i=2^k_i 
    M_i=2^k_i; % Le nombre de points dans la constellation QAM utilisée
    
    pond=2.^[(k_i-1):-1:0]; % Poids binaires
    symb_i=suite_bits(1:k_i)*pond'; % On associe un numéro de symbole à la sous-suite
                                    % de bits traitée dans la constellation associée
    suite_bits=suite_bits(k_i+1:length(suite_bits)); % On enlève les bits qui viennent d'être traités

    [Xi,Xq]=mapQAM(symb_i,M_i); % On calcule les coordonnées du symbole dans la constellation
    suite_symb(i)=Xi+j*Xq; % Coordonnées complexes du symbole
    
end