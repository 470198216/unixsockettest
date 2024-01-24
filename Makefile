CC := arm-linux-gnueabihf-gcc
PROJECT_DIR ?= ${shell pwd}
WARNINGS = -Wall -Wextra \
		   -Wshadow -Wundef -Wmaybe-uninitialized -Wmissing-prototypes -Wpointer-arith -Wuninitialized \
		   -Wunreachable-code -Wreturn-type -Wmultichar -Wdouble-promotion -Wclobbered -Wdeprecated  \
		   -Wempty-body -Wtype-limits -Wsizeof-pointer-memaccess

CFLAGS += -O3 -g0 $(WARNINGS) -I. 

LDFLAGS ?= -lm -lpthread

BIN = $(PROJECT_DIR)/output/dmclient
SERVERBIN = $(PROJECT_DIR)/output/dmserver

MAINSRC = $(PROJECT_DIR)/main.c
SERVERSRC = $(PROJECT_DIR)/server.c

OBJEXT ?= .o

MAINOBJ = $(MAINSRC:.c=$(OBJEXT))
SERVEROBJ = $(SERVERSRC:.c=$(OBJEXT))

## MAINOBJ -> OBJFILES
all: default

%.o: %.c
	@$(CC)  $(CFLAGS) -c $< -o $@ 
	@echo "CC $<"
	
default: $(MAINOBJ)
	$(CC) -o $(BIN) $(MAINOBJ)
	@mv $(PROJECT_DIR)/*.o $(PROJECT_DIR)/objs/

server: $(SERVEROBJ)
	$(CC) -o $(SERVERBIN) $(SERVEROBJ)
	@mv $(PROJECT_DIR)/*.o $(PROJECT_DIR)/objs/

clean: 
	@rm $(PROJECT_DIR)/objs/* $(BIN)
