all: string_manipulation

string_manipulation: string_manipulation.c functions.s
	@gcc -Wall -g -c string_manipulation.c -o string_manipulation
	@gcc -Wall -g -c functions.s -o functions
	@gcc -Wall string_manipulation functions -o string_manipulation.out
	@rm string_manipulation functions
	
clean:
	@rm string_manipulation functions
