# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

# dwm version
VERSION = 6.4

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = /usr/include/freetype2

INCS = -I${X11INC} -I${FREETYPEINC}
LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS}

CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700L -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS}
CFLAGS   = -std=c99 -pedantic -Wall -Wno-deprecated-declarations -Os ${INCS} ${CPPFLAGS}
CC = cc

SRC = src/drw.c src/dwm.c src/util.c
OBJ = ${SRC:.c=.o}


all: dwm

dirs:
	mkdir -p bin obj

obj/drw.o:
	${CC} -c ${CFLAGS} -o obj/drw.o src/drw.c

obj/dwm.o:
	${CC} -c ${CFLAGS} -o obj/dwm.o src/dwm.c

obj/util.o:
	${CC} -c ${CFLAGS} -o obj/util.o src/util.c

dwm: dirs obj/drw.o obj/dwm.o obj/util.o
	${CC} -o bin/dwm obj/drw.o obj/dwm.o obj/util.o ${LIBS}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f bin/dwm ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwm

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwm

clean:
	rm -rf bin/ obj/


.PHONY: all clean install uninstall
