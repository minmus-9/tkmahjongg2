tkmahjongg:	clean boards.tcl tiles.tcl tkmahjongg.head tkmahjongg.tail
	cat tkmahjongg.head boards.tcl tiles.tcl tkmahjongg.tail > $@
	chmod 755 $@

boards.tcl:
	sh boards.sh > $@

tiles.tcl:	
	sh tiles.sh > $@

install:	tkmahjongg
	mkdir -p $$HOME/bin $$HOME/.local/share/applications $$HOME/.local/share/icons
	cp tkmahjongg $$HOME/bin
	cp tkmahjongg.desktop $$HOME/.local/share/applications
	cp tkmahjongg.png $$HOME/.local/share/icons

uninstall:	
	rm $$HOME/.local/bin/tkmahjongg
	rm $$HOME/.local/share/applications/tkmahjongg.desktop
	rm $$HOME/.local/share/icons/tkmahjongg.png

clean:	
	rm -rf boards.tcl tiles.tcl tkmahjongg tiles/cooked
