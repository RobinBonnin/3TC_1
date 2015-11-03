#include <stdio.h>
#include <stdlib.h>

void copie (int caractere) {
#define TAILLE_MAX 64
  char chaine[64]; 
  FILE* fichier0=fopen("f0","w");
  FILE* fichier1=fopen("f1","w");
  FILE* fichier2=fopen("f2","w");
  FILE* fichier3=fopen("f3","w");
  FILE* fichier4=fopen("f4","w");
  FILE* fichier5=fopen("f5","w");

  switch (caractere) {
    case 0:
      fgets(chaine,TAILLE_MAX,fichier);
      fprintf(fichier0,"%s", chaine);
      fseek(fichier0,-1,SEEK_SET);
            
      break;
    case 1:                                                    
      fgets(chaine,TAILLE_MAX,fichier);
      fprintf(fichier1,"%s",chaine);
      break;
    case 2:
      fgets(chaine,TAILLE_MAX,fichier);
      fprintf(fichier3,"%s",chaine);
      break;
    case 3:
      fgets(chaine,TAILLE_MAX,fichier);
      fprintf(fichier3,"%s",chaine);
      break;
    case 4:
      fgets(chaine,TAILLE_MAX,fichier);
      fprintf(fichier4,"%s",chaine);
      break;
    case 5:
      fgets(chaine,TAILLE_MAX,fichier);
      fprintf(fichier5,"%s",chaine);
      break;
  }  


  int main () {
    int caractere;
    FILE* fichier=NULL;
    fichier=fopen("data.sujet","w");
    while(caractere!=EOF) {
      caractere=fgetc(fichier);
      if(caractere<6) {
        copie(caractere);
      }
      else {
        copie(0);
      }
    }
  }
