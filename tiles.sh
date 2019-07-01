#!/bin/sh

case "$1" in
    [Yy]*) color=y;;
        *) color=;;
esac

rm -rf tiles/cooked
mkdir -p tiles/cooked
cd tiles/cooked
find ../raw -name '*.png' -print | sort | (
    while read f; do
        g=`basename $f`
        lbl="X"
        geom="+30+20"
        size=20
        case "$g" in
            *-[0-9].png) continue;;
            face-down*) continue;;
            bamboo*|man*|pin*) lbl=`echo $g | tr -cd 0-9`;;
            dragon-chun*) lbl="C";;
            dragon-green*) lbl="G";;
            dragon-haku*) lbl="H";;
            flower-bamboo*) lbl="Bamboo"; geom=+0+12; size=16;;
            flower-chrys*) lbl="Mum"; geom=+8+16; size=16;;
            flower-orchid*) lbl="Orchid"; geom=+0+16; size=16;;
            flower-plum*) lbl="Plum"; geom=+8+16; size=16;;
            season-spring*) lbl="Spring"; geom=+0+12; size=16;;
            season-summer*) lbl="Summer"; geom=+0+12; size=16;;
            season-autumn*) lbl="Autumn"; geom=+0+12; size=16;;
            season-winter*) lbl="Winter"; geom=+0+12; size=16;;
            wind-north*) lbl=N;;
            wind-east*) lbl=E;;
            wind-south*) lbl=S;;
            wind-west*) lbl=W;;
        esac
        case "$g" in
            bamboo8*) geom=+0+8;;
            man[69]*) geom=+30+8;;
            pin8*) geom=+30+12;;
            *1*) geom=+30+12;;
            *2*) ;;
            *3*) ;;
            *4*) geom=+0+8;;
            *5*) geom=+0+8;;
            *6*) geom=+0+8;;
            *7*) ;;
            *8*) ;;
            *9*) geom=+0+7;;
        esac
        h=`echo $g | sed -e 's,\.png,\.xbm,'`
        convert $f \
            -gravity north \
            -fill black \
            -font DejaVu-Serif -pointsize $size \
            -annotate $geom $lbl \
            $g
    done
)

find . -name '*.png' -print | sort | (
    echo "########################################################################"
    echo "## tiles.tcl"
    echo
    tiles=""
    while read f; do \
        g=`basename $f | sed -e 's,\..*,,'`
        case "$g" in *-[0-9]) continue;; esac
        tiles="$tiles $g"
        echo "set bitmap_data($g) {"
        t=30
        case "$g" in
            bamboo1*) t=50;;
            season*|flower*) t=70;;
            wind*) t=60;;
        esac
        convert $f \
            -crop "80x120+24+8" +repage \
            -resize 120x180 \
            -channel R -threshold $t% \
            -channel G -threshold $t% \
            -channel B -threshold $t% \
            -trim \
            xbm:-
        echo "}"

        [ -z "$color" ] && continue

        echo "set image_data($g) {"
        base64 < $f
        echo "}"

        echo "set image_data($g-inv) {"
        convert -negate $f png:- | base64
        echo "}"
        echo
    done
    echo -n "set tiles {"
    echo -n $tiles
    echo "}"
    cat <<EOF

## EOF tiles.tcl

EOF
)
