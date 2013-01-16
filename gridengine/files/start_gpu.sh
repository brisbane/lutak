#!/bin/sh
#
# preparation of the gpu machine file
#
# usage: start_gpu.sh
#
# taken from: https://github.com/HPCKP/GPU-Integration-for-GridEngine/
#

GPUDIR=/opt/sge/gpu/var

if [ ! -e $GPUDIR/GPU0 ]; then
    touch $GPUDIR/GPU0
    export FREEGPU=0
elif [ ! -e $GPUDIR/GPU1 ]; then
    touch $GPUDIR/GPU1
    export FREEGPU=1
elif [ ! -e $GPUDIR/GPU2 ]; then
    touch $GPUDIR/GPU2
    export FREEGPU=2
else
    echo "ERROR: there are no free GPUs, check $GPUDIR"
    exit -1
fi

echo "$FREEGPU" > "$TMPDIR/gpumachine"
exit 0
