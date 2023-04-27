

mkdir b
cd b

REM Remove dot from PY_VER for use in library name
set MY_PY_VER=%PY_VER:.=%

set CXXFLAGS=/MP
set CFLAGS=/MP

REM Configure Step
cmake -T "v142,host=x64" -G "Visual Studio 16 2019" ^
    -D SimpleITK_BUILD_DISTRIBUTE:BOOL=ON ^
    -D BUILD_SHARED_LIBS:BOOL=OFF ^
    -D BUILD_TESTING:BOOL=OFF ^
    -D BUILD_EXAMPLES:BOOL=OFF ^
    -D WRAP_DEFAULT:BOOL=OFF ^
    -D WRAP_PYTHON:BOOL=ON ^
    -D SimpleITK_USE_SYSTEM_SWIG:BOOL=ON ^
    -D SimpleITK_PYTHON_USE_VIRTUALENV:BOOL=OFF ^
    -D ITK_USE_SYSTEM_JPEG:BOOL=OFF ^
    -D ITK_USE_SYSTEM_PNG:BOOL=OFF ^
    -D ITK_USE_SYSTEM_TIFF:BOOL=OFF ^
    -D ITK_USE_SYSTEM_ZLIB:BOOL=OFF ^
    -D Module_ITKTBB:BOOL=OFF ^
    -D "CMAKE_FIND_ROOT_PATH:PATH=%PREFIX%" ^
    -D "CMAKE_FIND_ROOT_PATH_MODE_INCLUDE:STRING=ONLY" ^
    -D "CMAKE_FIND_ROOT_PATH_MODE_LIBRARY:STRING=ONLY" ^
    -D "CMAKE_FIND_ROOT_PATH_MODE_PROGRAM:STRING=NEVER" ^
    -D "CMAKE_FIND_ROOT_PATH_MODE_PACKAGE:STRING=ONLY" ^
    -D "SWIG_EXECUTABLE:FILEPATH=%BUILD_PREFIX%\Library\bin\swig.exe" ^
    -D "CMAKE_PROGRAM_PATH=%BUILD_PREFIX%" ^
    -D "PYTHON_EXECUTABLE:FILEPATH=%PYTHON%" ^
    -D "PYTHON_INCLUDE_DIR:PATH=%PREFIX%\include" ^
    -D "PYTHON_LIBRARY:FILEPATH=%PREFIX%\libs\python%MY_PY_VER%.lib" ^
    "%SRC_DIR%\SuperBuild"

if errorlevel 1 exit 1

REM Build step
cmake --build  . --config MinSizeRel
if errorlevel 1 exit 1

REM Install step
REM cmake --build  . --config Release --target INSTALL
if errorlevel 1 exit 1

cd SimpleITK-build\Wrapping\Python
%PYTHON% setup.py install
