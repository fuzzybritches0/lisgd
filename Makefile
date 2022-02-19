PREFIX = /usr
SRC = lisgd.c
OBJ = ${SRC:.c=.o}
LDFLAGS = -linput -lm -lwayland-client

CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

all: options lisgd

options:
	@echo lisgd build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h

config.h:
	cp config.def.h $@

lisgd: ${OBJ}
	${CC} -g -o $@ ${OBJ} -I${X11INC} -lX11 ${LDFLAGS}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f lisgd ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/lisgd

	mkdir -p ${DESTDIR}${PREFIX}/share/man/man1
	cp lisgd.1 ${DESTDIR}${PREFIX}/share/man/man1
	chmod 755 ${DESTDIR}${PREFIX}/share/man/man1


clean:
	rm -f config.h
	rm -f lisgd

