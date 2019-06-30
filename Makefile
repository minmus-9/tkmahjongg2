SHARE=/usr/share
BIN=/usr/bin

all:	tkmahjongg2

tkmahjongg2:	boards.tcl tiles.tcl tkmahjongg2.head tkmahjongg2.tail
	cat tkmahjongg2.head boards.tcl tiles.tcl tkmahjongg2.tail > $@
	chmod 755 $@

boards.tcl:	boards.sh
	sh boards.sh > $@

tiles.tcl:	tiles.sh
	sh tiles.sh > $@

install:	tkmahjongg2
	mkdir -p $(BIN) $(SHARE)/applications $(SHARE)/icons
	cp tkmahjongg2 $(BIN)/
	cp tkmahjongg2.desktop $(SHARE)/applications/
	cp tkmahjongg2.png $(SHARE)/icons/

uninstall:	
	rm -f $(BIN)/tkmahjongg2
	rm -f $(SHARE)/applications/tkmahjongg2.desktop
	rm -f $(SHARE)/icons/tkmahjongg2.png

clean:	
	rm -rf boards.tcl tiles.tcl tkmahjongg2 tiles/cooked
