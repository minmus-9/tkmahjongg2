#!/bin/sh

rm -rf tiles/cooked
mkdir -p tiles/cooked
cd tiles/cooked
find ../raw -name '*.png' -print | sort | (
    while read f; do
        g=`basename $f`
        lbl="X"
        geom="+30+20"
        case "$g" in
            *-[0-9].png) continue;;
            face-down*) continue;;
            bamboo*|man*|pin*) lbl=`echo $g | tr -cd 0-9`;;
            dragon-chun*) lbl="C";;
            dragon-green*) lbl="G";;
            dragon-haku*) lbl="H";;
            flower-bamboo*) lbl="Bamboo"; geom=+0+16;;
            flower-chrys*) lbl="Chrysanthemum"; geom=+0+16;;
            flower-orchid*) lbl="Orchid"; geom=+0+16;;
            flower-plum*) lbl="Plum"; geom=+0+16;;
            season-spring*) lbl="Spring"; geom=+0+16;;
            season-summer*) lbl="Summer"; geom=+0+16;;
            season-autumn*) lbl="Autumn"; geom=+0+16;;
            season-winter*) lbl="Winter"; geom=+0+16;;
            wind-north*) lbl=N;;
            wind-east*) lbl=E;;
            wind-south*) lbl=S;;
            wind-west*) lbl=W;;
        esac
        convert $f -gravity north -annotate $geom $lbl -fill black \
            -font Times -pointsize 48 \
            $g
    done
)

find . -name '*.png' -print | sort | (
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
