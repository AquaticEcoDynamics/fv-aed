# #!/bin/sh
#
export GITHUB_WORKSPACE=`pwd`

cd $GITHUB_WORKSPACE/fv-source/libaed-fv/win
cmd.exe '/c build_fv.bat'
echo '========================='
cd $GITHUB_WORKSPACE/fv-source/libaed-fv/win/x64-Release
mkdir -p tuflowfv_external_wq
export VERSION=`grep FV_AED_VERS ../../src/fv_aed.F90 | grep define | cut -f2 -d\"`
mv tuflowfv_external_wq.??? tuflowfv_external_wq
powershell -Command "Compress-Archive -LiteralPath tuflowfv_external_wq -DestinationPath tuflowfv_external_wq_$VERSION.zip"
echo 
if [ ! -d $GITHUB_WORKSPACE/binaries/windows ] ; then
  mkdir -p $GITHUB_WORKSPACE/binaries/windows
fi
cp tuflowfv_external_wq_$VERSION.zip $GITHUB_WORKSPACE/binaries/windows
