#!/bin/bash -l

NAME=nacl
BADER=~/software/bader/bader
HOME=`pwd`
source nacl_com.sh
source nacl_submit.sh

if [ "$1" == 'input' ]
then
for i in {0..80}
do

digital=`printf "%02d" $i`
distance=`echo "2.0 + $i * 0.1" | bc`
halfdistance=`echo "scale=2; $distance / 2.0" | bc`
dirname=`echo $digital\_distance\_$distance`
#echo $digital $distance
echo $dirname
mkdir $dirname
cd $dirname
write_com $halfdistance nacl.com
write_submit submit.lsf nacl
cd $HOME

done
fi

if [ "$1" == 'run' ]
then
for i in {0..80}
do
digital=`printf "%02d" $i`
distance=`echo "2.0 + $i * 0.1" | bc`
dirname=`echo $digital\_distance\_$distance`
echo $dirname
cd $dirname
bsub < submit.lsf
cd $HOME

done
fi

if [ "$1" == 'analysis' ]
then
for i in {0..80}
do
digital=`printf "%02d" $i`
distance=`echo "2.0 + $i * 0.1" | bc`
dirname=`echo $digital\_distance\_$distance`
#echo $dirname
cd $dirname
totale=`awk '{ if($1=="2") {print $5}}' < ACF.dat`
e=`echo "$totale - 7" | bc`
echo $distance $e
cd $HOME

done
fi

if [ "$1" == 'analysis_energy' ]
then
for i in {0..80}
do
digital=`printf "%02d" $i`
distance=`echo "2.0 + $i * 0.1" | bc`
dirname=`echo $digital\_distance\_$distance`
#echo $dirname
cd $dirname
energy=`awk '{ if($1=="Total"&&$2=="Energy") {print $4}}' < nacl.fchk`
echo $distance $energy
cd $HOME

done
fi
