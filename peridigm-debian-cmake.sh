#!/bin/bash

rm -f CMakeCache.txt
 
# invoke cmake
cmake \
    -D CMAKE_BUILD_TYPE:STRING=Release \
    -D CMAKE_INSTALL_PREFIX:PATH=/usr/local/peridigm \
    -D CMAKE_EXE_LINKER_FLAGS:STRING="" \
    -D CMAKE_C_FLAGS:STRING="-O3" \
    -D CMAKE_CXX_FLAGS:STRING="-O3" \
    -D TRILINOS_DIR:PATH=/usr/local/trilinos \
    -D CMAKE_C_COMPILER:STRING=/usr/bin/mpicc \
    -D CMAKE_CXX_COMPILER:STRING=/usr/bin/mpicxx \
    -D BOOST_ROOT=/usr/include/boost \
    -D USE_DAKOTA:BOOL=OFF \
    ..

