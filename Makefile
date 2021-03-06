# How to Coverage Test
# 1. edit Makefile(CFLAGS contains --coverage)
# 2. make
# 3. run
# 4. make gcov

CC = gcc
#CFLAGS = -Wall -std=c11 -g -D_POSIX_C_SOURCE=200809L --coverage
CFLAGS = -Wall -std=c11 -g -D_POSIX_C_SOURCE=200809L
# electrice fence
#LIBS = -lgcov -lefence
LIBS = -lgcov 

TARGET = 9cc
SRCS = main.c init.c  symbol.c tokenize.c  parse.c sema.c codegen.c \
       node.c util.c  debug.c  util_test.c symbol_test.c pointer_test.c
OBJS = $(SRCS:.c=.o)

.PHONY: all clean check format gcov tags

all: $(TARGET)
clean:
	rm -f $(TARGET) $(OBJS) tmp* *~ \
              TAGS a.out core *.gcov *.gcno *.gcda *.png
	cd test; make clean
	cd sample; make clean
check: $(TARGET)
	./$(TARGET) -test
	cd test; make check
format:
	clang-format -i $(SRCS) *.h
	cd test; make format
	cd sample; make format
gcov: $(TARGET)
	gcov $(SRCS)
tags:
	etags $(SRCS) *.h

$(TARGET): $(OBJS)
	$(CC) -o $@ $(OBJS) $(LIBS)

$(OBJS): 9cc.h util.h

