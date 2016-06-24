#!/bin/bash
containsElement () {
 local e
 for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
 return 1
}
SRC_DIR="/etc/bahmni-installer/deployment-artifacts/modules"
DEST_DIR="/opt/openmrs/modules"
srcfullarray=($(\ls -m1 $SRC_DIR/*.omod | xargs -n1 basename))
srcarray=($(\ls -m1 $SRC_DIR/*.omod | xargs -n1 basename | sed -n "s/\(\S*\)-[0-9].*\.omod/\1/p"))
destarray=($(\ls -m1 $DEST_DIR/*.omod | xargs -n1 basename | sed -n "s/\(\S*\)-[0-9].*\.omod/\1/p"))
index=0
for srcomodFile in ${srcarray[@]}
    do
    echo "src" $srcomodFile
    srcfullname=${srcfullarray[index]}
    echo "srcfullname " ${srcfullarray[index]}
    if (( ${#destarray[@]} > 0 ))
    then
         if containsElement "$srcomodFile" "${destarray[@]}"
         then
            echo "Before remove"
            rm -rf $DEST_DIR/$srcomodFile*.omod
            echo "Copying" $SRC_DIR/$srcomodFile*.omod $DEST_DIR
            cp $SRC_DIR/$srcfullname $DEST_DIR
            echo "change ownership"
            chown bahmni:bahmni $DEST_DIR/$srcfullname
        else
            cp $SRC_DIR/$srcfullname $DEST_DIR
            chown bahmni:bahmni $DEST_DIR/$srcfullname
        fi
    else
        rm -rf $DEST_DIR/$srcomodFile*.omod
        cp $SRC_DIR/$srcfullname $DEST_DIR
        chown bahmni:bahmni $DEST_DIR/$srcfullname
    fi
    index=$((index+1))
done
