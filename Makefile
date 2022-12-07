OBJS = $(patsubst %.c, %.o, $(wildcard *.c))
MUSL_OBJS := lib/crt1.o lib/crti.o lib/crtn.o
BIN_NAME = main
TARGET= -mcpu=cortex-a15 -mfpu=vfpv3 -mfloat-abi=softfp
CFLAGS = $(TARGET) -std=c11 -I. -I include/ -nostdinc -O0 -g
LDFLAGS = $(TARGET) -static -nostartfiles -Wl,-Map=$(BIN_NAME).map -T link.lds
LIBLD = -lc -Llib/
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
	$(QUIET)$(CC) -o $@ $(LDFLAGS) $^ $(LIBLD)

clean : 
	rm -rf $(OBJS) $(BIN_NAME)
.PHONY = clean
