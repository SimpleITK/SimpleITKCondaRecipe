FROM centos:6.9

USER root

# Development tools and libraries
RUN yum install -y bzip2  glibc.i686 setarch

WORKDIR /tmp/
ADD https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh \
    https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86.sh \
    /tmp/
RUN /bin/bash /tmp/Miniconda2-latest-Linux-x86.sh -p /opt/miniconda2-32 -b && /opt/miniconda2-32/bin/conda install --yes --name root git conda-build
RUN /bin/bash /tmp/Miniconda2-latest-Linux-x86_64.sh -p /opt/miniconda2 -b && /opt/miniconda2/bin/conda install --yes --name root git conda-build 
RUN rm -f /tmp/Miniconda*


# User is expected to mount directory to "/work"
ENTRYPOINT ["bash", "-c", "groupadd -o -g $_GROUPID $_USER && useradd -m -o -g $_GROUPID $_USER -u $_USERID && chown -R $_USER /opt && su $_USER /work/io/imagefiles/cmd.sh" ]
