#!/bin/bash

source /work/miniconda2/bin/activate

export CHANNEL=giacomov

conda install conda-build -y
conda install anaconda-client -y

git clone https://github.com/giacomov/xspec-modelsonly.git

cd xspec-modelsonly/conda_recipe/

anaconda login --username $CHANNEL
conda config --set anaconda_upload yes

conda build cfitsio
conda build wcslib -c $CHANNEL
conda build ccfits -c $CHANNEL
conda build xspec-modelsonly -c $CHANNEL
