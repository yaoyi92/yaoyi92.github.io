#!/bin/bash
function write_submit {
cat > $1 << EOF
#!/bin/bash -l
#BSUB -e err.%J
#BSUB -o out.%J

module load gaussian
g09 $2.com
formchk $2.chk
cubegen 0 fdensity=cc $2.fchk test.cube -1 < ../cubegen.in
~/software/bader/bader test.cube

EOF
}
