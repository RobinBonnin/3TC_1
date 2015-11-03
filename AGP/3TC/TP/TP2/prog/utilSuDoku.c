#include <stdlib.h>
#include <stdio.h>
#include <string.h>


int lireSudoku(FILE *fich,int sudoku[9][9])
{int i,j,res;
  int val; 
  for (i=0; i<9; i++) 
    for (j=0; j<9; j++) 
    {
      res=fscanf(fich, "%d",&val);
      if (res==EOF)
      {
        fprintf(stderr,"Fin de ficher atteinte: manque des coefficients\n");
        exit(-1);
      }
      sudoku[i][j]=val;
    }
  return(0);
}

int ecrireSudoku(FILE *fich,int sudoku[9][9])
{int i,j;
  for (i=0; i<9; i++) 
  {
    for (j=0; j<9; j++) 
    {
      fprintf(fich, "%d ",sudoku[i][j]);
    }
    fprintf(fich, "\n");
  }
  return(0);
}

int sudokuValide (int sudoku[9][9]) {
  int h,l,i,j,k,val,valide;
  valide=1;
  for(l=0;l<3;l++){//Choix de la ligne du bloc
    for(h=0;h<3;h++){//Choix de la colonne du bloc
      for(k=1;k<10;k++) {//Chiffre à vérifier : k
        val=0;
        for(i=0;i<3;i++){
          i=l*3+i;//Changement de bloc
          for(j=0;j<3;j++) {
            j=h*3+j;//Changement de bloc
            if(sudoku[i][j]==k){
              val=val+1;
            }
            if(val>1){
              valide=0;
            }
          }
        }
      }
    }

  }

 for(j=0;j<9;j++){//Parcours des lignes 
    for(k=1;k<10;k++) { //k : valeur à vérifier
      val=0;
      for(i=0;i<9;i++){ //Parcours de la ligne
        if(sudoku[i][j]==k){
          val=val+1; //val :nombre de fois que l'on rencontre k 
        }
        if(val>1) {
          valide=0;
        }
      }
    }
  }

  for(i=0;i<9;i++){ //Parcours des colonnes
    for(k=1;k<10;k++) {
      val=0;
      for(j=0;j<9;j++){ //Parcours de colonnes
        if(sudoku[i][j]==k){
          val=val+1;
        }
        if(val>1) {
          valide=0;
        }
      }
    }
  }
  printf("Validité :%d\n",valide);
  return(valide);
}





