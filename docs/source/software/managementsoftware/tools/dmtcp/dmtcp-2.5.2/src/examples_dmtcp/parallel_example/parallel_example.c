#include <stdio.h>
#include <time.h>

int main (int argc, char *argv[]) {
  int rank, size;
  time_t rawtime;
  
  //compiled with gcc -fopenmp  helloWorldOpenMP.c -o
#pragma omp parallel private(rank, rawtime)
  {
    rank = omp_get_thread_num();
    printf("Hello World from thread = %d\n", rank);

    if (rank == 0) 
      {
	size = omp_get_num_threads();
	printf("Number of threads = %d\n", size);
      }
 
    int i = 0;
    for (i = 0; i < 60; i++){
      sleep(1);
      time(&rawtime);
      printf("%d on thread %d of %d\n",i, rank, size);
      printf("%s", ctime(&rawtime));
    }
    printf( "Goodbye world from process %d of %d\n", rank, size );
  } 
}
