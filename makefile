CC=gcc
DIR_INC=./include
DIR_SRC_CL=./src/modbusClient
DIR_SRC_SE=./src/modbusServer
DIR_SRC_CM=./src/common
DIR_SRC = ./src/*
DIR_OBJ=./obj
DIR_BIN=./bin
DIR_LIB= /mnt/hgfs/sharedFolder

CFLAG = -Wall -g
LDFLAG = -Wl,--rpath-link=$(DIR_LIB)/lib
#指定Include的路径
INCLUDE= -I$(DIR_INC)

#指定lib的路径
LIBS=-L$(DIR_LIB)/lib -lmodbus -lpthread

TARGET_S=$(DIR_BIN)/modbusServer
SRC1=$(wildcard ${DIR_SRC_SE}/*.c)
TARGET_C=$(DIR_BIN)/modbusClient
SRC2=$(wildcard ${DIR_SRC_CL}/*.c)
SRC3=$(wildcard ${DIR_SRC_CM}/*.c)

OBJ1=$(SRC1:$(DIR_SRC_SE)/%.c=$(DIR_OBJ)/%.o)
OBJ2=$(SRC2:$(DIR_SRC_CL)/%.c=$(DIR_OBJ)/%.o)
OBJ3=$(SRC3:$(DIR_SRC_CM)/%.c=$(DIR_OBJ)/%.o)

start:$(OBJ1) $(OBJ2) $(OBJ3)
	$(CC) $(LDFLAG) -o $(TARGET_S) $(OBJ1) $(OBJ3) $(LIBS)
	$(CC) $(LDFLAG) -o $(TARGET_C) $(OBJ2) $(OBJ3) $(LIBS)
	@echo "^_^ ------  OK ------ ^_^"

$(DIR_OBJ)/%.o:$(DIR_SRC)/%.c
	$(CC) -o $@ -c $< $(CFLAG) $(INCLUDE)
clean:
	rm -f $(OBJ1)
	rm -f $(OBJ2)
	rm -f $(TARGET_S)
	rm -f $(TARGET_C)
