#!/bin/bash

# When building 32-bits on 64-bit system this flags is not automatically set by conda-build
if [ $ARCH == 32 -a "${OSX_ARCH:-notosx}" == "notosx" ]; then
    export CFLAGS="${CFLAGS} -m32"
    export CXXFLAGS="${CXXFLAGS} -m32"
fi

BUILD_DIR=${SRC_DIR}/build
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}


PYTHON_INCLUDE_DIR=$(${PYTHON} -c 'import sysconfig;print("{0}".format(sysconfig.get_path("platinclude")))')
PYTHON_LIBRARY=$(${PYTHON} -c 'import sysconfig;print("{0}/{1}".format(*map(sysconfig.get_config_var, ("LIBDIR", "LDLIBRARY"))))')

cmake \
    -G Ninja \
    ${CMAKE_ARGS} \
    -D "CMAKE_CXX_FLAGS:STRING=-fvisibility=hidden -fvisibility-inlines-hidden ${CXXFLAGS}" \
    -D "CMAKE_C_FLAGS:STRING=-fvisibility=hidden ${CFLAGS}" \
    -D "CMAKE_FIND_ROOT_PATH:PATH=${PREFIX}" \
    -D "CMAKE_FIND_ROOT_PATH_MODE_INCLUDE:STRING=ONLY" \
    -D "CMAKE_FIND_ROOT_PATH_MODE_LIBRARY:STRING=ONLY" \
    -D "CMAKE_FIND_ROOT_PATH_MODE_PROGRAM:STRING=NEVER" \
    -D "CMAKE_FIND_ROOT_PATH_MODE_PACKAGE:STRING=ONLY" \
    -D "CMAKE_FIND_FRAMEWORK:STRING=NEVER" \
    -D "CMAKE_FIND_APPBUNDLE:STRING=NEVER" \
    -D "CMAKE_PROGRAM_PATH=${BUILD_PREFIX}" \
    -D SimpleITK_GIT_PROTOCOL:STRING=git \
    -D SimpleITK_BUILD_DISTRIBUTE:BOOL=ON \
    -D SimpleITK_BUILD_STRIP:BOOL=ON \
    -D SimpleITK_EXPLICIT_INSTANTIATION:BOOL=OFF \
    -D CMAKE_BUILD_TYPE:STRING=RELEASE \
    -D BUILD_SHARED_LIBS:BOOL=OFF \
    -D BUILD_TESTING:BOOL=OFF \
    -D BUILD_EXAMPLES:BOOL=OFF \
    -D WRAP_DEFAULT:BOOL=OFF \
    -D WRAP_PYTHON:BOOL=ON \
    -D "PYTHON_EXECUTABLE:FILEPATH=${PYTHON}" \
    -D "PYTHON_INCLUDE_DIR:PATH=${PYTHON_INCLUDE_DIR}" \
    -D "PYTHON_LIBRARY=${PYTHON_LIBRARY_DIR}" \
    -D SimpleITK_USE_SYSTEM_SWIG:BOOL=ON \
    -D SimpleITK_PYTHON_USE_VIRTUALENV:BOOL=OFF \
    -D "SWIG_EXECUTABLE:FILEPATH=${BUILD_PREFIX}/bin/swig" \
    -D ITK_USE_SYSTEM_JPEG:BOOL=ON \
    -D ITK_USE_SYSTEM_PNG:BOOL=ON \
    -D ITK_USE_SYSTEM_TIFF:BOOL=ON \
    -D ITK_USE_SYSTEM_ZLIB:BOOL=ON \
    -D ITK_C_OPTIMIZATION_FLAGS:STRING= \
    -D ITK_CXX_OPTIMIZATION_FLAGS:STRING= \
    -D GDCM_USE_COREFOUNDATION_LIBRARY:BOOL=OFF \
    "${SRC_DIR}/SuperBuild"

cmake --build . --config Release
cd ${BUILD_DIR}/SimpleITK-build/Wrapping/Python
${PYTHON} setup.py install
