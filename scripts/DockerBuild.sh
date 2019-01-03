
docker build --pull=true  --rm=true -t simpleitk_conda-bld -f imagefiles/Dockerfile .


if [ -n "$ExternalData_OBJECT_STORES" -a -d "$ExternalData_OBJECT_STORES" ] ; then
    external_data_args="-v ${ExternalData_OBJECT_STORES}:/var/io/.ExternalData -e ExternalData_OBJECT_STORES=/var/io/.ExternalData"
fi


docker run --rm -e _USER=$(id -un)  -e _USERID=$(id -u)  -e _GROUPID=$(id -g) $external_data_args -v $(pwd):/work/io -t simpleitk_conda-bld
docker run --rm -e ARCH=32 -e _USER=$(id -un)  -e _USERID=$(id -u)  -e _GROUPID=$(id -g) $external_data_args -v $(pwd):/work/io -t simpleitk_conda-bld
