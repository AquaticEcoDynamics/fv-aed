#!/bin/sh

export SINGLE=false
export PRECISION=1
export PLOTS=false
export EXTERNAL_LIBS=shared
export DEBUG=false

export LICENSE=0

case `uname` in
  "Darwin"|"Linux"|"FreeBSD")
    export OSTYPE=`uname -s`
    ;;
  MINGW*)
    export OSTYPE="Msys"
    ;;
esac

export CC=gcc
if [ "$OSTYPE" = "FreeBSD" ] ; then
  export FC=flang
  export CC=clang
else
  export FC=ifort
fi

while [ $# -gt 0 ] ; do
  case $1 in
    --debug)
      export DEBUG=true
      ;;
    --fence)
      export FENCE=true
      ;;
    --static)
      export EXTERNAL_LIBS=static
      ;;
    --single)
      export SINGLE=true
      ;;
    --no-ben)
      export NO_BEN=true
      ;;
    --no-demo)
      export NO_DEMO=true
      ;;
    --no-rip)
      export NO_RIP=true
      ;;
    --no-dev)
      export NO_DEV=true
      ;;
    *)
      ;;
  esac
  shift
done


export MAKE=make
if [ "$OSTYPE" = "FreeBSD" ] ; then
  if [ "$FC" = "" ] ; then
    export FC=flang
  fi
  export MAKE=gmake
fi

if [ "$FC" = "" ] ; then
  export FC=ifort
fi

if [ "$FC" = "ifort" ] ; then
  if [ "$OSTYPE" = "Msys" ] ; then
    export PATH="$PATH:/c/Program Files (x86)/Intel/oneAPI/compiler/latest/windows/bin/intel64"
  else
    export start_sh="$(ps -p "$$" -o  command= | awk '{print $1}')" ;
    # ifort config scripts wont work with /bin/sh
    # so we restart using bash
    if [ "$start_sh" = "/bin/sh" ] ; then
      /bin/bash $0
      exit $?
    fi
    if [ -d /opt/intel ] ; then
      if [ -x /opt/intel/setvars.sh ] ; then
        . /opt/intel/setvars.sh
      elif [ -x /opt/intel/oneapi/setvars.sh ] ; then
        . /opt/intel/oneapi/setvars.sh
      elif [ -d /opt/intel/bin ] ; then
        . /opt/intel/bin/compilervars.sh intel64
      fi
    fi
    which ifort > /dev/null 2>&1
    if [ $? != 0 ] ; then
       echo ifort compiler requested, but not found
       exit 1
    fi
  fi
fi

export F77=$FC
export F90=$FC
export F95=$FC

export CURDIR=`pwd`
export AEDFVDIR=${CURDIR}/libaed-fv
if [ ! -d ${AEDFVDIR} ] ; then
  echo no libaed-fv directory?
  exit 1
fi

echo build libaed-water
cd  ${CURDIR}/libaed-water
${MAKE} || exit 1
PARAMS=""
if [ ! -d ${CURDIR}/libaed-benthic ] ; then NO_BEN=true ; fi
if [ "${NO_BEN}" != "true" ] ; then
  echo build libaed-benthic
  cd  ${CURDIR}/libaed-benthic
  ${MAKE} || exit 1
  export DAEDBENDIR=`pwd`
  echo BEN = $DAEDBENDIR
  PARAMS="${PARAMS} AEDBENDIR=${DAEDBENDIR}"
fi
if [ ! -d ${CURDIR}/libaed-riparian ] ; then NO_RIP=true ; fi
if [ "${NO_RIP}" != "true" ] ; then
  echo build libaed-riparian
  cd  ${CURDIR}/libaed-riparian
  ${MAKE} || exit 1
  export DAEDRIPDIR=`pwd`
  echo RIP = $DAEDRIPDIR
  PARAMS="${PARAMS} AEDRIPDIR=${DAEDRIPDIR}"
fi
if [ ! -d ${CURDIR}/libaed-demo ] ; then NO_DEMO=true ; fi
if [ "${NO_DEMO}" != "true" ] ; then
  echo build libaed-demo
  cd  ${CURDIR}/libaed-demo
  ${MAKE} || exit 1
  export DAEDDMODIR=`pwd`
  echo DMO = $DAEDDMODIR
  PARAMS="${PARAMS} AEDDMODIR=${DAEDDMODIR}"
fi
if [ ! -d ${CURDIR}/libaed-dev ] ; then NO_DEV=true ; fi
if [ "${NO_DEV}" != "true" ] ; then
  echo build libaed-dev
  cd  ${CURDIR}/libaed-dev
  ${MAKE} || exit 1
  export DAEDDEVDIR=`pwd`
  echo DEV = $DAEDDEVDIR
  PARAMS="${PARAMS} AEDDEVDIR=${DAEDDEVDIR}"
fi

echo build tfv_wq
if [ -f ${AEDFVDIR}/obj/aed_external.o ] ; then
  /bin/rm ${AEDFVDIR}/obj/aed_external.o
fi
${MAKE} -C ${AEDFVDIR} ${PARAMS} || exit 1

#ISODATE=`date +%Y%m%d`
#if [ "$PRECISION" = "1" ] ; then
#   if [ "$SINGLE" = "true" ] ; then
#     S='_ss'
#   else
#     S='_sd'
#   fi
#else
#   S='_dd'
#fi
#if [ "$DEBUG" = "true" ] ; then
#   D='_d'
#else
#   D=''
#fi
#
#if [ "$OSTYPE" = "Linux" ] ; then
#  if [ $(lsb_release -is) = Ubuntu ] ; then
#    T=_u
#  else
#    T=_r
#  fi
#fi
#EXTN="_$ISODATE$T$S$D"
LFV_VERS=`grep FV_AED_VERS ${AEDFVDIR}/src/fv_aed.F90 | grep define | cut -f2 -d\"`

cd ${CURDIR}

if [ "$EXTERNAL_LIBS" = "shared" ] ; then
  if [ "$OSTYPE" = "Darwin" ] ; then
    MOSLINE=`grep 'SOFTWARE LICENSE AGREEMENT FOR ' '/System/Library/CoreServices/Setup Assistant.app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf'`
    MOSNAME=`echo ${MOSLINE} | awk -F 'macOS ' '{print $NF}'  | tr -d '\\' | tr ' ' '_'`

    BINPATH="binaries/macos/${MOSNAME}"
  fi
  if [ "$OSTYPE" = "Linux" ] ; then
    if [ $(lsb_release -is) = Ubuntu ] ; then
      BINPATH="binaries/ubuntu/$(lsb_release -rs)"
    fi
  fi

  if [ ! -d ${BINPATH} ] ; then
     mkdir -p ${BINPATH}
  fi

  cd ${CURDIR}/libaed-fv/lib
  tar czf ${CURDIR}/${BINPATH}/libtuflowfv_external_wq_${LFV_VERS}.tar.gz libtuflowfv_external_wq.*
fi

exit 0
