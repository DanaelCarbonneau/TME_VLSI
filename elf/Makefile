AS_ARM = /usr/bin/arm-linux-gnu-as
LD_ARM = /usr/bin/arm-linux-gnu-ld
CFLAGS = -march=armv2a 
LD_FLAGS = -Bstatic -fix-v4bx

all : test1.elf


add.elf : add.s
	${AS_ARM} ${CFLAGS} -c add.s -o add


test1.elf : test1.s
	${AS_ARM} ${CFLAGS} -c test1.s -o test1

pgcd.elf : pgcd.asm
	${AS_ARM} ${CFLAGS} -c pgcd.asm -o pgcd


clean :
	rm -f test1.elf *.o


