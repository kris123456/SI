.PHONY: all
all: prog_asm.exe prog_pas.exe

asm_to_pas.exe: asm_to_pas.pl
	swipl --traditional -o asm_to_pas.exe -c asm_to_pas.pl --goal=main 2>/dev/null

prog.pas: prog1.asm asm_to_pas.exe
	./asm_to_pas.exe <prog1.asm >prog_new.pas
	if [ -f prog.pas ] && diff prog.pas prog_new.pas >/dev/null ; then rm -f prog_new.pas ; else mv prog_new.pas prog.pas ; fi

prog_asm.exe: prog_asm.obj printers.obj readers.obj
	g++ -m32 -Wall prog_asm.obj printers.obj readers.obj -o prog_asm.exe

prog_asm.obj: prog1.asm
	nasm -fwin32 prog1.asm
	mv prog1.obj prog_asm.obj

printers.obj: printers.cpp
	g++ -m32 -std=c++11 -Wall -O2 -c printers.cpp -o printers.obj

readers.obj: readers.cpp
	g++ -m32 -std=c++11 -Wall -O2 -c readers.cpp -o readers.obj

prog_pas.exe: prog.pas
	fpc prog.pas >/dev/null
	rm -f prog.o
	mv prog.exe prog_pas.exe

.PHONY: clean
clean:
	rm -f ./*.o ./*.obj ./*.exe ./prog.pas ./prog_new.pas ./output_*.txt ./asm_to_pas.pl~
