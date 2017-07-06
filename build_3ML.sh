#!/bin/bash

source /work/miniconda2/bin/activate

export CHANNEL=giacomov

conda install conda-build -y
conda install anaconda-client -y

git clone https://github.com/giacomov/3ML.git

cd /work/3ML/conda-dist

anaconda login --username $CHANNEL
conda config --set anaconda_upload yes

source deactivate

./make_packages.sh

