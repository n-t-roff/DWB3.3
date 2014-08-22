CFLAGS = -O -DWORD32
IFLAG = -i
OFILES = y1.o y2.o y3.o y4.o

all: yacc

yacc:	$(OFILES)
	$(CC) $(LDFLAGS) $(IFLAG) -s -o yacc $(OFILES)

y2.o:   y2.c
	$(CC) $(CFLAGS) -TR2 -c y2.c

$(OFILES): dextern files

