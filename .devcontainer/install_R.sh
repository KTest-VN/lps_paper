#!/bin/bash
set -ue  # Exit on error and treat unset variables as error

# Install R base
apt-get update
apt-get install -y r-base

# Install remotes for versioned packages
R -e "install.packages('remotes', repos='https://cloud.r-project.org')"

# Install specific versions of required packages
R -e "remotes::install_version('data.table', version='1.17.8', repos='https://cloud.r-project.org')"
R -e "remotes::install_version('ggplot2', version='3.5.2', repos='https://cloud.r-project.org')"
R -e "remotes::install_version('scales', version='1.4.0', repos='https://cloud.r-project.org')"
