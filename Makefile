BASE64=base64

tkmahjongg:	clean boards.tcl tiles.tcl tkmahjongg.head tkmahjongg.tail
	cat tkmahjongg.head boards.tcl tiles.tcl tkmahjongg.tail > $@

boards.tcl:
	find boards -type f -print | sort | ( \
	boards=""; \
	echo "########################################################################"; \
	echo "## boards.tcl"; \
	echo; \
	while read f; do \
		g=`basename $$f`; \
		boards="$$boards $$g"; \
		echo "set board_data($$g) {"; \
		sed -e 's,[ 	]*#.*,,' -e '/^$$/d' < $$f; \
		echo "}"; \
		echo; \
	done; \
	echo -n "set boards {"; \
	echo -n $$boards; \
	echo "}"; \
	echo; \
	) > $@

tiles.tcl:	
	find tiles/raw -name '*.png' -print | sort | ( \
	echo "########################################################################"; \
	echo "## tiles.tcl"; \
	echo; \
	while read f; do \
		g=`basename $$f | sed -e 's,\..*,,'`; \
		echo "set image_data($$g) {"; \
		$(BASE64) < $$f; \
		echo "}"; \
		echo; \
	done) > $@

clean:	
	rm -f boards.tcl tiles.tcl tkmahjongg
