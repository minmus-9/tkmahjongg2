#!/bin/sh

find tiles/raw -name '*.png' -print | sort | (
    echo "########################################################################"
    echo "## tiles.tcl"
    echo
    normal=""
    while read f; do \
        g=`basename $f | sed -e 's,\..*,,'`
        case "$g" in *-[0-9]) continue;; esac
        normal="$normal $g"
        echo "set image_data($g) {"
        base64 < $f
        echo "}"
        echo "set image_data($g-inv) {"
        convert -negate $f png:- | base64
        echo "}"
        echo
    done
    echo -n "set tiles_normal {"
    echo -n $normal
    echo "}"
    cat <<EOF

## EOF tiles.tcl

EOF
)
