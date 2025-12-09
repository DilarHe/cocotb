main:main.o my.o
	gcc main.o my.o -o main
main.o:main_test.c
	gcc -c main_test.c
my.o:my.c
	gcc -c my.c 

.PHONY:clean

#linux 下用 rm -rf *.o main
clean:
	@echo "=======clean project========="
	rm  *.o 
	@echo "=======clean completed========="
