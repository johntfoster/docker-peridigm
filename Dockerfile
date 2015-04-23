FROM johntfoster/trilinos

MAINTAINER John Foster <johntfosterjr@gmail.com>

ENV HOME /root

RUN apt-get -yq install git
RUN apt-get -yq install libboost1.49-all-dev
RUN apt-get -yq install openmpi-bin
RUN apt-get -yq install openssh-server

#Let's hack around setting up ssh key to clone a private github repo.
RUN mkdir -p /root/.ssh
ADD id_rsa /root/.ssh/id_rsa
ADD id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/authorized_keys
RUN echo "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

#Build Peridigm
RUN git clone git@github.com:johntfoster/Peridigm.git peridigm
RUN mkdir -p /peridigm/build
WORKDIR /peridigm/build/
RUN /usr/local/cmake/bin/cmake \
    -D CMAKE_BUILD_TYPE:STRING=Release \
    -D CMAKE_INSTALL_PREFIX:PATH=/usr/local/peridigm \
    -D CMAKE_CXX_FLAGS:STRING="-O3" \
    -D TRILINOS_DIR:PATH=/usr/local/trilinos \
    -D CMAKE_CXX_COMPILER:STRING=/usr/bin/mpicxx \
    -D BOOST_ROOT=/usr/include/boost \
    -D USE_DAKOTA:BOOL=OFF \
    ..; \
    make && make install; \
    cd ..; \
    rm -rf peridigm

VOLUME /output
WORKDIR /output
ENV LD_LIBRARY_PATH /usr/local/netcdf/lib

RUN mkdir /var/run/sshd
EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
