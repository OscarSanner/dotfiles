#!/bin/bash

SINK=$( pactl list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1 )
NOW=$( pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' )
REQUESTED_CHANGE=0;
MODIFIER=""

[ "$#" -lt 2 ] && echo "Not enough arguments provided" && exit 1
[ "$#" -gt 2 ] && echo "Too many arguments provided" && exit 1
[ "$1" != "-inc" ] && [ "$1" != "-dec" ] && echo "First argument has to be either '-inc' or '-dec'" && exit 1
! [ "$2" -eq "$2" ] 2>/dev/null && echo "Second argument has to be a number" && exit 1  

[ "$1" == "-dec" ] && REQUESTED_CHANGE=$(( $2*-1 )) || REQUESTED_CHANGE=$2 
[ "$1" == "-inc" ] && MODIFIER="+"

[ $(( REQUESTED_CHANGE+NOW )) -gt 100 ] && REQUESTED_CHANGE=$(( 100-NOW ))  

pactl -- set-sink-volume @DEFAULT_SINK@  "$MODIFIER""$REQUESTED_CHANGE"%
