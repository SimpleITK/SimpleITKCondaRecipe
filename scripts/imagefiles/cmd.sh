#!/usr/bin/bash
set -x

if [ "${ARCH}" = "32" -o  "${ARCH}" = "x86" ]; then
    CONDA_ROOT=${CONDA_ROOT:-/opt/miniconda2-32}
    LINUX32=/usr/bin/linux32
else
    CONDA_ROOT=${CONDA_ROOT:-/opt/miniconda2}
fi
CONDA=${CONDA_ROOT}/bin/conda
PYTHON_VERSIONS=${PYTHON_VERSIONS:-"36 35 34 27"}
OUTPUT_DIR=${OUTPUT_DIR:-/work/io/channel}

. ${CONDA_ROOT}/etc/profile.d/conda.sh
conda activate

cd /tmp
git clone https://github.com/SimpleITK/SimpleITKCondaRecipe.git
CONDA_RECIPES=$(pwd)/SimpleITKCondaRecipe

(${CONDA} update -y -n root conda conda-build )|| (echo "conda-build needs to be installed into conda\!";exit 1)

cd ${CONDA_RECIPES}

echo "PYTHON_VERSIONS: ${PYTHON_VERSIONS}"
for PYV in ${PYTHON_VERSIONS}; do
    echo
    ${LINUX32} ${CONDA} build --python ${PYV} --output-folder ${OUTPUT_DIR} recipe #simpleitk
done



