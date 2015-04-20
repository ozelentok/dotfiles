CC = g++
FLAGS = -Wall -Werror -O2 -std=c++11

all: zspower
zspower: zspower.cpp
	$(CC) $(FLAGS) $^ -o $@
	strip $@
clean:
	rm -f zspower
