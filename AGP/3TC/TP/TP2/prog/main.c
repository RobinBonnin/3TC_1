#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "utilSuDoku.h"
	 
int  main(int argc,char *argv[])
{
  FILE *fich;
  char *nomFich ;
  int sudoku[9][9];
  
  if (argc!=2)
    {
      fprintf(stdout," usage: sudoku nomFich.txt \n");
      exit(-1);
    }
  nomFich=(char *)malloc(100*sizeof(char));
  strcpy(nomFich,argv[1]);
  fich=fopen(nomFich,"r");
  if (!fich)
    fprintf(stderr,"erreur d'ouverture du fichier\n");
  
 lireSudoku(fich,sudoku); 
 fprintf(stdout," sudoku lu: \n");
 int i=sudokuValide(sudoku);
 ecrireSudoku(stdout,sudoku);

   return(0);
}
