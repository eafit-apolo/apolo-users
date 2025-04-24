# BayeScan makefile

CC=icpc

bayescan_2.1: start.o beta.o dirichlet.o RJupdates.o MHupdates.o likelihood.o read_write.o anyoption.o
	$(CC) -fopenmp -static -lpthread -o bayescan_2.1 start.o beta.o dirichlet.o RJupdates.o MHupdates.o likelihood.o read_write.o anyoption.o

start.o: start.cpp errors.cpp anyoption.h global_defs.h
	$(CC) -fopenmp -c start.cpp errors.cpp

beta.o: beta.cpp global_defs.h
	$(CC) -fopenmp -c beta.cpp

dirichlet.o: dirichlet.cpp global_defs.h
	$(CC) -fopenmp -c dirichlet.cpp

RJupdates.o: RJupdates.cpp global_defs.h
	$(CC) -fopenmp -c RJupdates.cpp

MHupdates.o: MHupdates.cpp global_defs.h
	$(CC) -fopenmp -c MHupdates.cpp

likelihood.o: likelihood.cpp global_defs.h
	$(CC) -fopenmp -c likelihood.cpp

read_write.o: read_write.cpp errors.cpp global_defs.h
	$(CC) -fopenmp -c read_write.cpp errors.cpp

anyoption.o: anyoption.cpp anyoption.h
	$(CC) -fopenmp -c anyoption.cpp

clean:
	rm *.o bayescan_2.1
