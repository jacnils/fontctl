include options.mk

help:
	@echo "make install     Install ${NAME}."
	@echo "make uninstall   Uninstall ${NAME}."
	@echo "make clean:      Remove tarballs."
	@echo "make dist        Create distro package for ${NAME}."

install: clean
	cp ${NAME} ${PREFIX}${DESTDIR}/bin
	chmod +x ${PREFIX}${DESTDIR}/bin/${NAME}

uninstall:
	rm -rf ~/.config/${NAME}
	rm -f ${PREFIX}${DESTDIR}/bin/${NAME}

clean:
	rm -f *.tar* *zst* *${NAME}-${VER}.PKGBUILD

dist: clean
	mkdir -p ${NAME}-${VER}
	cp ${NAME} README.md LICENSE Makefile *.mk ${NAME}-${VER}
	[ -f "PKGBUILD" ] && cp -f PKGBUILD ${NAME}-${VER} || :
	tar -cf ${NAME}-${VER}.tar ${NAME}-${VER}
	gzip ${NAME}-${VER}.tar
	rm -rf ${NAME}-${VER}.tar ${NAME}-${VER}
	gpg --detach-sign --yes --local-user $$(whoami) ${NAME}-${VER}.tar.gz || :
