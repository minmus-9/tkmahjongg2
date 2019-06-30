all:	tkmahjongg2

tkmahjongg2:	boards.tcl tiles.tcl tkmahjongg2.head tkmahjongg2.tail
	cat tkmahjongg2.head boards.tcl tiles.tcl tkmahjongg2.tail > $@
	chmod 755 $@

boards.tcl:	boards.sh
	sh boards.sh > $@

tiles.tcl:	tiles.sh
	sh tiles.sh > $@

install:	tkmahjongg2
	mkdir -p $$HOME/bin $$HOME/.local/share/applications $$HOME/.local/share/icons
	cp tkmahjongg2 $$HOME/bin
	cp tkmahjongg2.desktop $$HOME/.local/share/applications
	cp tkmahjongg2.png $$HOME/.local/share/icons

uninstall:	
	rm -f $$HOME/bin/tkmahjongg2
	rm -f $$HOME/.local/share/applications/tkmahjongg2.desktop
	rm -f $$HOME/.local/share/icons/tkmahjongg2.png

clean:	
	rm -rf boards.tcl tiles.tcl tkmahjongg2 tiles/cooked
