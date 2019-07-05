#!/usr/bin/env bash
set -x


CONDA=${CONDA:-$(which conda)}
CONDA_RECIPES=${CONDA_RECIPES:-${HOME}/src/SimpleITKCondaRecipe}
PYTHON_VERSIONS=${PYTHON_VERSIONS:-"27 34 35 36"}
OUTPUT_FOLDER=${OUTPUT_FOLDER:-$(pwd)/channel}

cd ${CONDA_RECIPES}

for PYV in ${PYTHON_VERSIONS}; do
    ${CONDA} build --python ${PYV} --output-folder ${OUTPUT_FOLDER} recipe #simpleitk
done


# find . -name simpleitk\*tar.bz2

#${CONDA} upload --user simpleitk --channel dev ~/anaconda/conda-bld/linux-32/simpleitk-0.9.0b01-py34_0.tar.bz2
