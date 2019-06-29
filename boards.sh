#!/bin/sh

find boards -type f -print | sort | (
    boards=""
    echo "########################################################################"
    echo "## boards.tcl"
    echo
    while read f; do
        g=`basename $f`
        boards="$boards $g"
        echo "set board_data($g) {"
        sed -e 's,[ 	]*#.*,,' -e '/^$/d' < $f
        echo "}"
        echo
    done
    echo -n "set boards {"
    echo -n $boards
    echo "}"
    cat <<EOF

## EOF boards.tcl

EOF
)
