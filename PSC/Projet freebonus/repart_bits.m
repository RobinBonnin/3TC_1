function vect_alloc=repart_bits(nb_canaux,h_moy_abs,noise_moy_abs)

% Cette fonction impl�mente l'algorithme du "water pouring" qui permet de traiter l'allocation des bits dans 
% les canaux en fonction de leur RSB. 

% nb_canaux est le nombre de canaux sur lequel on travaille.  
% h_moy_abs est un vecteur ligne de longueur nb_canaux dont la i-�me composante correspond 
% au module au carr� de la fonction de transfert du i-�me canal.
% noise_moy_abs est un vecteur ligne de longueur nb_canaux dont la i-�me composante correspond 
% � la puissance de bruit du i-�me canal.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

Pe=nb_canaux*1; % Puissance totale �mise correspondant � la somme des puissances de 
                % chaque sous porteuse (normalis�e � 1 Watt)
W=4.3125*10^3; % Largeur de bande occup�e par la sous-porteuse d'un canal
D=W*nb_canaux*6; % D�bit voulu en upstream (en bps)
p=0.0000001; % Probabilit� d'erreur maximale 
Kmax=8; % Nombre maximum de bits pouvant etre distribu�s dans un canal
 
% Calcul de gamma (coefficient qui permettra de calculer la puissance � r�partir dans les canaux et 
% l'indice de modulation QAM utilis� dans chaque canal) :
gamma=double(solve('erfc(x)=0.0000001/4')); % erfc(x)=Q(x) (fonction erreur).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D�termination du nombre de bits allou�s dans chaque canal %
% par calcul de la r�partition de la puissance totale       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

P=zeros(1,nb_canaux); % La i-�me composante de P est la puissance du i-�me canal
M=zeros(1,nb_canaux); % La i-�me composante de M est le nombre de points de la constellation du i-�me canal
k=zeros(1,nb_canaux); % La i-�me composante de R correspond au nombre de bits attribu�s au i-�me canal

for i=1:nb_canaux
    P(i)=1/nb_canaux*(Pe+(gamma^2./3)*sum(noise_moy_abs./h_moy_abs))-(noise_moy_abs(i)*gamma^2)./(3*h_moy_abs(i));
    if P(i)<0 
        P(i)=0; % On �vite les puissances n�gatives
    end
    M(i)=1+(3*P(i)*h_moy_abs(i))/(noise_moy_abs(i)*gamma^2);
    k(i)= log2(M(i));
end
debit=W*sum(k); % D�bit atteint au terme de la boucle


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajustement par rapport aux performances d�sir�es %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if debit<D % Les performances sont impossibles � atteindre
    disp('Les performances d�sir�es ne peuvent etre atteintes, il faut augmenter la probabilit� maximale p')
    return
    
else % Les performances sont r�alisables
    e=floor((debit-D)/(nb_canaux*W));
    for i=1:nb_canaux
        if e<k(i) % Evite les k(i) n�gatifs 
            k(i)=k(i)-e; % On s'arrange pour que le d�bit atteint ne soit pas trop loin du d�bit fix� D
        end
        
        if k(i)>=Kmax+0.5 % Evite d'avoir un nombre de bits par canaux sup�rieur � Kmax
            k(i)=Kmax;
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Egalisation du d�bit atteint et du d�bit fix� %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k_ref=k; % On sauvegarde les valeurs du vecteur k
debit=W*sum(round(k)); % D�bit r�ellement atteint
diff_bit=k-round(k); % On cr�e un vecteur diff_bit qui contient l'erreur faite sur le nombre de
                     % bits attribu�s apr�s arrondi. Ce vecteur permettra de 'jouer' sur la
                     % r�partition des bits � chaque tour de boucle
indic=0; % Indicateur qui permettra de savoir si le vecteur diff_bit doit �tre recalcul� � la fin de la boucle

while abs(debit-D)>100 % Tant que le d�bit atteint est trop diff�rent du d�bit voulu...
    
    if debit<D % Si le d�bit r�ellement atteint est insuffisant on va rajouter un bit sur une sous-porteuse    
        [maximum,ind_max]=max(diff_bit); % On cherche l'indice du plus grand �l�ment de diff_bits.
                                         % Cet �l�ment est donc celui sur lequel on a commis la plus
                                         % grande erreur d'arrondi
        
        if k(ind_max)>=Kmax % Si le nombre de bits allou� au canal dont le diff_bit est le plus grand 
                            % est sup�rieur ou egal � Kmax, on s'arrange pour selectionner un autre ind_max...
            diff_bit(ind_max)=diff_bit(ind_max)-0.1; % ...en d�cr�mentant tr�s l�g�rement le diff_bit courant
            indic=1; % On met l'indicateur � 1 pour ne pas recalculer le vecteur diff_bit
        else % Sinon, on ajoute directement un bit sur la sous-porteuse associ�e
            k(ind_max)=k(ind_max)+1; % Sinon, on rajoute un bit � la sous-porteuse dont le diff_bit est le plus grand
        end
        
    else % Si le d�bit r�ellement atteint est trop grand
        [minimum,ind_min]=min(diff_bit); % On cherche l'indice du plus petit �l�ment de diff_bits
                                         % Cet �l�ment est donc celui sur lequel on a commis la plus
                                         % grande erreur d'arrondi
        
        if k(ind_min)<=0 % Si le nombre de bits allou� au canal dont le diff_bit est le plus petit 
                         % est inf�rieur ou egal � 0, on s'arrange pour selectionner un autre ind_min...
            diff_bit(ind_min)=diff_bit(ind_min)+0.1; % ...en incr�mentant tr�s l�g�rement le diff_bit courant
            indic=1; % On met l'indicateur � 1 pour ne pas recalculer le vecteur diff_bit
        else
            k(ind_min)=k(ind_min)-1; % Sinon, on enl�ve un bit � la sous-porteuse dont le diff_bit est le plus petit
        end   
    end

    debit=round(W*sum(round(k))); % On recalcule le d�bit r�ellement atteint avec le nouveau vecteur k    
    if indic==0 % Si indic vaut 0, on a modifi� les valeurs du vecteur k, il faut donc recalculer le vecteur diff_bits
        diff_bit=k_ref-round(k); % On recalcule le vecteur diff_bit, par rapport aux valeurs initiales de k
    end
    indic=0; % On r�initialise l'indicateur
    
end

vect_alloc=round(k); % On retourne des valeurs enti�res