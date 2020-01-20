#include <stdio.h>

int main(int argc, char *argv[]){
  FILE *fp;
  if (argc == 2){
    fp = fopen(argv[1], "rb+");
  } else {
    printf("-- Error: Please indicate file! One argument only!!!");
    return(1);
  }
  if (NULL==fp){
    printf("Error opening the file\n");
    return(1);
  };
  int c = fgetc(fp);
  c ^= 'D';
  rewind(fp);  
  putc(c, fp);
  return(0);
}
