tkmahjongg:	clean boards.tcl tiles.tcl tkmahjongg.head tkmahjongg.tail
	cat tkmahjongg.head boards.tcl tiles.tcl tkmahjongg.tail > $@

boards.tcl:
	sh boards.sh > $@

tiles.tcl:	
	sh tiles.sh > $@

clean:	
	rm -f boards.tcl tiles.tcl tkmahjongg
