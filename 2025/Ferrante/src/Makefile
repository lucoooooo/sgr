UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Linux)
    PKG_CONFIG_PATH := /usr/lib/pkgconfig
else ifeq ($(UNAME_S),Darwin)
    PKG_CONFIG_PATH := /opt/homebrew/lib/pkgconfig
endif

# Prova a prendere flags da pkg-config per ndpi
NDPI_CFLAGS := $(shell pkg-config --cflags libndpi 2>/dev/null)
NDPI_LIBS := $(shell pkg-config --libs libndpi 2>/dev/null)

# Prova a prendere flags da pkg-config per rrdtool
RRDTOOL_CFLAGS := $(shell pkg-config --cflags librrd 2>/dev/null)
RRDTOOL_LIBS := $(shell pkg-config --libs librrd 2>/dev/null)

# Compiler
CC := gcc
CFLAGS := -Wall -O2 $(NDPI_CFLAGS) $(RRDTOOL_CFLAGS) -lpthread
LDFLAGS := $(NDPI_LIBS) $(RRDTOOL_LIBS) -lnetsnmp

# File sorgente e output
SRC := port_similarity.c
OUT := port_similarity

# Cartelle di lavoro
RRDS := rrds/
TEST := test/

.PHONY: all clean run-remote run-local run-test

all: $(OUT)
	mkdir -p $(TEST)
	mkdir -p $(RRDS)

$(OUT): $(SRC)
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

run-remote: all
	./$(OUT) -h 200.58.174.254 -v -z

run-local: all
	./$(OUT) -l -v -z -S 10

run-test: all
	./gentest.sh
	./$(OUT) -v -z -c $(TEST) -t 100

clean:
	rm -f $(OUT)
	rm -rf $(RRDS)
	rm -rf $(TEST)
