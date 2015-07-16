CC = g++
FLAGS = -Wall -Wextra -Wconversion -Wsign-conversion -Wformat-security -pie -fPIE -Wl,-z,relro,-z,now -Werror -O2 -std=c++11

all: zspower
zspower: zspower.cpp
	$(CC) $(FLAGS) $^ -o $@
	strip $@
clean:
	rm -f zspower
