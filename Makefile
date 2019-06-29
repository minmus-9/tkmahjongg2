tkmahjongg:	clean boards.tcl tiles.tcl tkmahjongg.head tkmahjongg.tail
	cat tkmahjongg.head boards.tcl tiles.tcl tkmahjongg.tail > $@

boards.tcl:
	sh boards.sh > $@

tiles.tcl:	
	sh tiles.sh > $@

install:	
	cp tkmahjongg.desktop /usr/share/applications
	cp tkmahjongg.png /usr/share/icons

uninstall:	
	rm /usr/share/applications/tkmahjongg.desktop
	rm /usr/share/icons/tkmahjongg.png

clean:	
	rm -f boards.tcl tiles.tcl tkmahjongg
