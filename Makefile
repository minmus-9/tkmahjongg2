SHARE=/usr/share
BIN=/usr/bin

all:	tkmahjongg2

tkmahjongg2:	boards.tcl desktop.tcl icon.tcl tiles.tcl tkmahjongg2.head tkmahjongg2.tail
	cat tkmahjongg2.head desktop.tcl icon.tcl boards.tcl tiles.tcl tkmahjongg2.tail > $@
	chmod 755 $@

boards.tcl:	boards.sh
	sh boards.sh > $@

tiles.tcl:	tiles.sh
	sh tiles.sh > $@

desktop.tcl:	tkmahjongg2.desktop
	(echo "set desktop_data {"; cat $<; echo "}"; echo) > $@

icon.tcl:	tkmahjongg2.png
	(echo "set icon_data {"; base64 < $<; echo "}"; echo) > $@

install:	tkmahjongg2
	cp tkmahjongg2 $(BIN)/
	$(BIN)/tkmahjongg2 -init

uninstall:	
	rm -f $(BIN)/tkmahjongg2
	rm -f $(SHARE)/applications/tkmahjongg2.desktop
	rm -f $(SHARE)/icons/tkmahjongg2.png

clean:	
	rm -rf boards.tcl desktop.tcl icon.tcl tiles.tcl tkmahjongg2 tiles/cooked
