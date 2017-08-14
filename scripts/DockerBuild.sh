
docker build --pull=true  --rm=true -t simpleitk_conda-bld -f imagefiles/Dockerfile .

docker run --storage-opt size=150G --rm -e _USER=$(id -un)  -e _USERID=$(id -u)  -e _GROUPID=$(id -g) $external_data_args -v $(pwd):/work/io -t simpleitk_conda-bld
docker run --storage-opt size=150G --rm -e ARCH=32 -e _USER=$(id -un)  -e _USERID=$(id -u)  -e _GROUPID=$(id -g) $external_data_args -v $(pwd):/work/io -t simpleitk_conda-bld
