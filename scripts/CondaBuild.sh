#!/usr/bin/env bash
set -x

CONDA_ROOT=${CONDA_ROOT:-${HOME}/miniconda2}
CONDA_RECIPES=${CONDA_RECIPES:-${HOME}/src/SimpleITKCondaRecipe}
PYTHON_VERSIONS=${PYTHON_VERSIONS:-"27 34 35 36"}

if [ -x ${CONDA_ROOT}/bin/conda ]; then
    CONDA=${CONDA_ROOT}/bin/conda
elif [ -x ${CONDA_ROOT}/Scripts/conda ]; then
    CONDA=${CONDA_ROOT}/Scripts/conda
else
    echo "Unable to find conda executable"
fi


${CONDA} update -n root conda conda-build -y

cd ${CONDA_RECIPES}

for PYV in ${PYTHON_VERSIONS}; do
    ${CONDA} build --python ${PYV} --output-folder channel recipe #simpleitk
done


find ${CONDA_ROOT}/conda-bld -name simpleitk\*tar.bz2

#${CONDA} upload --user simpleitk --channel dev ~/anaconda/conda-bld/linux-32/simpleitk-0.9.0b01-py34_0.tar.bz2
