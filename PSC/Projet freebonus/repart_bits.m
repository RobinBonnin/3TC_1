function vect_alloc=repart_bits(nb_canaux,h_moy_abs,noise_moy_abs)

% Cette fonction implémente l'algorithme du "water pouring" qui permet de traiter l'allocation des bits dans 
% les canaux en fonction de leur RSB. 

% nb_canaux est le nombre de canaux sur lequel on travaille.  
% h_moy_abs est un vecteur ligne de longueur nb_canaux dont la i-ème composante correspond 
% au module au carré de la fonction de transfert du i-ème canal.
% noise_moy_abs est un vecteur ligne de longueur nb_canaux dont la i-ème composante correspond 
% à la puissance de bruit du i-ème canal.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

Pe=nb_canaux*1; % Puissance totale émise correspondant à la somme des puissances de 
                % chaque sous porteuse (normalisée à 1 Watt)
W=4.3125*10^3; % Largeur de bande occupée par la sous-porteuse d'un canal
D=W*nb_canaux*6; % Débit voulu en upstream (en bps)
p=0.0000001; % Probabilité d'erreur maximale 
Kmax=8; % Nombre maximum de bits pouvant etre distribués dans un canal
 
% Calcul de gamma (coefficient qui permettra de calculer la puissance à répartir dans les canaux et 
% l'indice de modulation QAM utilisé dans chaque canal) :
gamma=double(solve('erfc(x)=0.0000001/4')); % erfc(x)=Q(x) (fonction erreur).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Détermination du nombre de bits alloués dans chaque canal %
% par calcul de la répartition de la puissance totale       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

P=zeros(1,nb_canaux); % La i-éme composante de P est la puissance du i-ème canal
M=zeros(1,nb_canaux); % La i-éme composante de M est le nombre de points de la constellation du i-ème canal
k=zeros(1,nb_canaux); % La i-éme composante de R correspond au nombre de bits attribués au i-ème canal

for i=1:nb_canaux
    P(i)=1/nb_canaux*(Pe+(gamma^2./3)*sum(noise_moy_abs./h_moy_abs))-(noise_moy_abs(i)*gamma^2)./(3*h_moy_abs(i));
    if P(i)<0 
        P(i)=0; % On évite les puissances négatives
    end
    M(i)=1+(3*P(i)*h_moy_abs(i))/(noise_moy_abs(i)*gamma^2);
    k(i)= log2(M(i));
end
debit=W*sum(k); % Débit atteint au terme de la boucle


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajustement par rapport aux performances désirées %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if debit<D % Les performances sont impossibles à atteindre
    disp('Les performances désirées ne peuvent etre atteintes, il faut augmenter la probabilité maximale p')
    return
    
else % Les performances sont réalisables
    e=floor((debit-D)/(nb_canaux*W));
    for i=1:nb_canaux
        if e<k(i) % Evite les k(i) négatifs 
            k(i)=k(i)-e; % On s'arrange pour que le débit atteint ne soit pas trop loin du débit fixé D
        end
        
        if k(i)>=Kmax+0.5 % Evite d'avoir un nombre de bits par canaux supérieur à Kmax
            k(i)=Kmax;
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Egalisation du débit atteint et du débit fixé %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k_ref=k; % On sauvegarde les valeurs du vecteur k
debit=W*sum(round(k)); % Débit réellement atteint
diff_bit=k-round(k); % On crée un vecteur diff_bit qui contient l'erreur faite sur le nombre de
                     % bits attribués après arrondi. Ce vecteur permettra de 'jouer' sur la
                     % répartition des bits à chaque tour de boucle
indic=0; % Indicateur qui permettra de savoir si le vecteur diff_bit doit être recalculé à la fin de la boucle

while abs(debit-D)>100 % Tant que le débit atteint est trop différent du débit voulu...
    
    if debit<D % Si le débit réellement atteint est insuffisant on va rajouter un bit sur une sous-porteuse    
        [maximum,ind_max]=max(diff_bit); % On cherche l'indice du plus grand élément de diff_bits.
                                         % Cet élément est donc celui sur lequel on a commis la plus
                                         % grande erreur d'arrondi
        
        if k(ind_max)>=Kmax % Si le nombre de bits alloué au canal dont le diff_bit est le plus grand 
                            % est supérieur ou egal à Kmax, on s'arrange pour selectionner un autre ind_max...
            diff_bit(ind_max)=diff_bit(ind_max)-0.1; % ...en décrémentant très légèrement le diff_bit courant
            indic=1; % On met l'indicateur à 1 pour ne pas recalculer le vecteur diff_bit
        else % Sinon, on ajoute directement un bit sur la sous-porteuse associée
            k(ind_max)=k(ind_max)+1; % Sinon, on rajoute un bit à la sous-porteuse dont le diff_bit est le plus grand
        end
        
    else % Si le débit réellement atteint est trop grand
        [minimum,ind_min]=min(diff_bit); % On cherche l'indice du plus petit élément de diff_bits
                                         % Cet élément est donc celui sur lequel on a commis la plus
                                         % grande erreur d'arrondi
        
        if k(ind_min)<=0 % Si le nombre de bits alloué au canal dont le diff_bit est le plus petit 
                         % est inférieur ou egal à 0, on s'arrange pour selectionner un autre ind_min...
            diff_bit(ind_min)=diff_bit(ind_min)+0.1; % ...en incrémentant très légèrement le diff_bit courant
            indic=1; % On met l'indicateur à 1 pour ne pas recalculer le vecteur diff_bit
        else
            k(ind_min)=k(ind_min)-1; % Sinon, on enlève un bit à la sous-porteuse dont le diff_bit est le plus petit
        end   
    end

    debit=round(W*sum(round(k))); % On recalcule le débit réellement atteint avec le nouveau vecteur k    
    if indic==0 % Si indic vaut 0, on a modifié les valeurs du vecteur k, il faut donc recalculer le vecteur diff_bits
        diff_bit=k_ref-round(k); % On recalcule le vecteur diff_bit, par rapport aux valeurs initiales de k
    end
    indic=0; % On réinitialise l'indicateur
    
end

vect_alloc=round(k); % On retourne des valeurs entières