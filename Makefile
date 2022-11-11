OBJS = $(patsubst %.c, %.o, $(wildcard *.c))
MUSL_OBJS := lib/crt1.o lib/crti.o lib/crtn.o lib/libc.a
BIN_NAME = main
CFLAGS = -std=c11 -I. -I../usr/include -nostdinc -nostdlib -O0 -g -nostartfiles
LDFLAGS = -static -nostartfiles -nostdlib -Wl,-Map=$(BIN_NAME).map
VERBOSE?=0

ifeq ($(VERBOSE), 0)
QUIET:=@
CC = $(QUIET)echo "CC $@ <| $^"; arm-none-eabi-gcc
else
QUIET:=
CC = arm-none-eabi-gcc
endif


# $(warning $(OBJS))

$(BIN_NAME) : $(OBJS) $(MUSL_OBJS)

clean : 
	rm -rf $(OBJS) $(BIN_NAME)
.PHONY = clean
