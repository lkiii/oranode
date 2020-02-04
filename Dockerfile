#
# ---- Base Node & Oracle ----
FROM oraclelinux:7-slim as base
ENV LD_LIBRARY_PATH="/usr/lib/oracle/18.3/client64/lib/"
RUN yum-config-manager yum-config-manager --add-repo http://yum.oracle.com/public-yum-ol7.repo && \
    yum-config-manager --enable ol7_oracle_instantclient && \
    yum install -y oracle-instantclient18.3-basic && \
    ln -s $LD_LIBRARY_PATH/libclntsh.so.18.1 $LD_LIBRARY_PATH/libclntsh.so && \
    #node
    yum install -y sudo make && \
    curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash - && \
    yum install -y nodejs && \
    yum update -y nodejs && \
    # cleanup
    yum clean all

# Create app directory
WORKDIR /app
