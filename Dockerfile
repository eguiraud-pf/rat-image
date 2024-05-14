# need ubunt 24.04 for a recent-enough version of armadillo
FROM ubuntu:24.04

# Instructions at https://gitlab.com/Project-Rat/rat-documentation/-/blob/master/linux_cc8_install.md
# adapted for Ubuntu 22.04 instead of centos 8 
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
    git \
    gcc \
    g++ \
    cmake \
    make \
    liblapack-dev \
    intel-mkl \
    libarmadillo-dev \
    mpich \
    libvtk9-dev \
    libjsoncpp-dev \
    libtclap-dev \
    libboost-all-dev \
    paraview-dev 

ENV MKL_NUM_THREADS 1
# I don't think we need this
# ENV LD_LIBRARY_PATH /opt/intel/mkl/lib/intel64/

WORKDIR /root/project-rat
COPY build_rat_project.sh .
RUN ./build_rat_project.sh rat-common
RUN ./build_rat_project.sh distmesh-cpp
RUN ./build_rat_project.sh materials-cpp
RUN ./build_rat_project.sh rat-mlfmm
RUN ./build_rat_project.sh rat-models
RUN ./build_rat_project.sh rat-nl
