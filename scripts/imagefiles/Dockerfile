FROM centos:5.11

USER root

# Centos 5 is EOL and is no longer available from the usual mirrors, so switch
# to http://vault.centos.org
# From: https://github.com/rust-lang/rust/pull/41045
# The location for version 5 was also removed, so now only the specific release
# (5.11) can be referenced.
RUN sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf
RUN sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/*.repo
RUN sed -i 's/#\(baseurl.*\)mirror.centos.org\/centos\/$releasever/\1vault.centos.org\/5.11/' /etc/yum.repos.d/*.repo

# Development tools and libraries
RUN yum install -y make gcc-c++ bzip2  setarch
RUN yum install -y zlib.i386 libgcc.i386 libstdc++-devel.i386  glibc-devel.i386
RUN yum install -y epel-release
RUN yum install -y git

WORKDIR /tmp/
ADD https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh \
    https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86.sh \
    /tmp/
RUN /bin/bash /tmp/Miniconda2-latest-Linux-x86_64.sh -p /opt/miniconda2 -b && /opt/miniconda2/bin/conda install -n root conda-build -y
RUN /bin/bash /tmp/Miniconda2-latest-Linux-x86.sh -p /opt/miniconda2-32 -b && /opt/miniconda2-32/bin/conda install -n root conda-build -y
RUN rm -f /tmp/Miniconda*


# User is expected to mount directory to "/work"
ENTRYPOINT ["bash", "-c", "groupadd -o -g $_GROUPID $_USER && useradd -m -o -g $_GROUPID $_USER -u $_USERID && chown -R $_USER /opt && su $_USER /work/io/imagefiles/cmd.sh" ]
