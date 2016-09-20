###############################################################################################
######################################### WSTĘP ###############################################
###############################################################################################
# Program svgDiag.sh jest skryptem stworzonym przez Krzysztofa Zajączkowskiego ################
# dostępnym na licencji GPL 3.0 <https://www.gnu.org/licenses/gpl-3.0.html> ###################
# program dostępny na stronie obliczeniowo.com.pl/?id=487 #####################################
###############################################################################################
# OSTRZEŻENIE: ################################################################################
# Autor programu dołożył wszelkich starań, aby nie sprawiało ono żadnych kłopotów i nie #######
# wykonywało żadnych działań mających na celu uszkodzenie, zniszczenie lub utratę danych ######
# zawartych na dysku jego użytkownika. Jakkolwiek nie da się wszystkiego przewidzieć ##########
# a oprogramowanie to w trakcie pracy TWORZY na dysku twardym plik ghtml w miejscu jego #######
# uruchomienia ################################################################################
###############################################################################################
# WYŁĄCZENIE ODPOWIEDZIALNOSĆI: ###############################################################
###############################################################################################
# Z wyżej wymienionych względów autor programu NIE PONOSI odpowiedzialności karnej za #########
# niepożądane skutki działania niniejszego skryptu, zaś użytkownik wykorzystuje skrypt na #####
# WŁASNĄ ODPOWIEDZIALNOŚĆ #####################################################################
###############################################################################################

###############################################################################################
########################################## Introduction #######################################
###############################################################################################
# Program svgDiag.sh is a BASH script made by Krzysztof Zajaczkowski under licence GPL 3.0 ####
# <https://www.gnu.org/licenses/gpl-3.0.html> and this program is avaible on hre and on my ####
# page obliczeniowo.com.pl/?id=487 ############################################################
###############################################################################################
# WARNING #####################################################################################
# Author of this script make an effort to be sure that this script dont make any troubles and #
# dont make any actions that can damage or destroy data on your computer. However it's can't ##
# everything predict and that script when he work create on your disc file html in place of ###
# his own location ############################################################################
###############################################################################################
# You use this script on your own responsibility. #############################################
###############################################################################################

header="<!doctype html><html><head><meta charset=\"UTF-8\"></head><body><!-- Created with Skrypt created by author of page (http://www.obliczeniowo.com.pl/?id=387) --><svg width=\"1200\" height=\"1000\">"

end="</svg></body></html>"

rect ()
{
	echo "<polygon fill=\"$1\" stroke=\"$2\" stroke-width=\"1\" points=\"$3 $4 $3 $(($4-$6)) $(($3+$5)) $(($4-$6)) $(($3+$5)) $4 \" />"
}
getHexColor()
{
    r=$(printf "%x\n" $1)
    if [ ${#r} -lt 2 ]
    then
        r="0$r"
    fi
    g=$(printf "%x\n" $2)
    if [ ${#g} -lt 2 ]
    then
        g="0$g"
    fi
    b=$(printf "%x\n" $3)
    if [ ${#b} -lt 2 ]
    then
        b="0$b"
    fi
    echo "#$r$g$b"
}
drawText ()
{
    # $1 - tekst
    # $2 - x
    # $3 - y
    # $4 - rozmiar czcionki
    # $5 - kolor wypełnienia
    echo "<text font-size=\""$4"px\" fill=\""$5"\" text-anchor=\"middle\" stroke=\"none\" stroke-width=\"2\" x=\""$2"\" y=\""$3"\"><tspan x=\""$2"\" y=\""$3"\">$1</tspan></text>"
}
drawPost ()
{
    color=$(getHexColor $1 $2 $3)
    color2=$(getHexColor $(($1-20)) $2 $3)
    color3=$(getHexColor $1 $(($2-20)) $3)
    p="<polygon fill=\"$color3\" stroke=\"$4\" stroke-width=\"1\" points=\"$5 $(($6-$8)) $(($5+$7)) $(($6-$8)) $(($5+$7*3/2)) $(($6-$8-$7/2)) $(($5+$7*1/2)) $(($6-$8-$7/2))\" />"
    p=$p"<polygon fill=\"$color2\" stroke=\"$4\" stroke-width=\"1\" points=\"$(($5+$7)) $6 $(($5+$7*3/2)) $(($6-$7/2)) $(($5+$7*3/2)) $(($6-$7/2-$8)) $(($5+$7)) $(($6-$8))\" />"
    p=$p$(drawText $9 "$(($5+$7/2))" "$(($6-$8-$7*3/4))" 20 "#000000")
    p=$p$(rect $color $4 $5 $6 $7 $8 $9)
    
    echo $p
}
max()
{
    max=0
    for i in $1;
    do
        if [ $max = 0 ]
        then
            max=$i
        elif [ $max -lt $i ]
        then
            max=$i
        fi
    done
    
    echo $max;
}
getHexColor()
{
    r=$(printf "%x\n" $1)
    if [ ${#r} -lt 2 ]
    then
        r="0$r"
    fi
    g=$(printf "%x\n" $2)
    if [ ${#g} -lt 2 ]
    then
        g="0$g"
    fi
    b=$(printf "%x\n" $3)
    if [ ${#b} -lt 2 ]
    then
        b="0$b"
    fi
    echo "#$r$g$b"
}
count()
{
    c=0;
    for i in $1;
    do
        c=$((c+1));
    done
    
    echo $c;
}
if [ ${#1} = 0 ]
then
    values="100 200 500 20 700 800 30 400 500 1000 200"
else
    values="$1"
fi
max_height=800
max_width=1000
echo $values;
max_value=$(max "$values");

echo "maksimum: "$max_value

counting=$(count "$values");

echo "liczba zmiennych: "$counting;

post_width=$((max_width/counting))

echo "szerokość słupka wykresu: "$post_width

c=0;
if [ ${#2} != 0 ]
then
    r=$(drawText "$2" 600 40 30 "#000000");
fi
for i in $values
do
    r=$r$(drawPost 100 100 $((c*255/counting)) "#000000" "$((20+post_width*c))" $((max_height+150)) $post_width $((i*max_height/max_value)) $i)
    c=$((c+1));
done
if [ ${#3} != 0 ]
then
    echo $header$r$end>$3.html
else
    echo $header$r$end>plik.html
fi
