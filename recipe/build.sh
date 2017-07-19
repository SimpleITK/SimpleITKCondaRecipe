#!/bin/bash

if [ `uname` == Darwin ]; then
    SO_EXT='dylib'
    CMAKE_ARGS="-D CMAKE_OSX_DEPLOYMENT_TARGET:STRING=${MACOSX_DEPLOYMENT_TARGET}"
else
    SO_EXT='so'
fi

# When building 32-bits on 64-bit system this flags is not automatically set by conda-build
if [ $ARCH == 32 -a "${OSX_ARCH:-notosx}" == "notosx" ]; then
    export CFLAGS="${CFLAGS} -m32"
    export CXXFLAGS="${CXXFLAGS} -m32"
fi

BUILD_DIR=${SRC_DIR}/build
mkdir ${BUILD_DIR}
cd ${BUILD_DIR}

MY_PY_VER=${PY_VER}
if [ $PY3K -eq "1" ]; then
    MY_PY_VER="${MY_PY_VER}m"
fi

cmake \
    -D "CMAKE_CXX_FLAGS:STRING=-fvisibility=hidden -fvisibility-inlines-hidden ${CXXFLAGS}" \
    -D "CMAKE_C_FLAGS:STRING=-fvisibility=hidden ${CFLAGS}" \
    ${CMAKE_ARGS} \
    -D SimpleITK_GIT_PROTOCOL:STRING=git \
    -D SimpleITK_BUILD_DISTRIBUTE:BOOL=ON \
    -D SimpleITK_BUILD_STRIP:BOOL=ON \
    -D CMAKE_BUILD_TYPE:STRING=RELEASE \
    -D BUILD_SHARED_LIBS:BOOL=OFF \
    -D BUILD_TESTING:BOOL=OFF \
    -D BUILD_EXAMPLES:BOOL=OFF \
    -D WRAP_DEFAULT:BOOL=OFF \
    -D WRAP_PYTHON:BOOL=ON \
    -D SimpleITK_USE_SYSTEM_SWIG:BOOL=ON \
    -D ITK_USE_SYSTEM_JPEG:BOOL=ON \
    -D ITK_USE_SYSTEM_PNG:BOOL=ON \
    -D ITK_USE_SYSTEM_TIFF:BOOL=ON \
    -D ITK_USE_SYSTEM_ZLIB:BOOL=ON \
    -D "CMAKE_SYSTEM_PREFIX_PATH:FILEPATH=${PREFIX}" \
    -D "PYTHON_EXECUTABLE:FILEPATH=${PYTHON}" \
    -D "PYTHON_INCLUDE_DIR:PATH=$PREFIX/include/python${MY_PY_VER}" \
    -D "PYTHON_LIBRARY:FILEPATH=$PREFIX/lib/libpython${MY_PY_VER}.${SO_EXT}" \
    -D "SWIG_EXECUTABLE:FILEPATH=${PREFIX}/bin/swig" \
    "${SRC_DIR}/SuperBuild"

make -j ${CPU_COUNT}
cd ${BUILD_DIR}/SimpleITK-build/Wrapping/Python
${PYTHON} Packaging/setup.py install

