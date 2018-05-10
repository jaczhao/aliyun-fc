FROM node:4.4.7

MAINTAINER alibaba-serverless-fc

# Environment variables.
ENV FC_SERVER_PATH=/var/fc/runtime/nodejs4.4 \
    NODE_PATH=/usr/local/lib/node_modules \
    FC_FUNC_CODE_PATH=/code
ENV PATH=${FC_FUNC_CODE_PATH}/node_modules/.bin:${PATH}
ENV LD_LIBRARY_PATH=${FC_FUNC_CODE_PATH}:${FC_FUNC_CODE_PATH}/lib

# Create directory.
RUN mkdir -p ${FC_FUNC_CODE_PATH}

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources.list /etc/apt/

# Change work directory.
WORKDIR ${FC_FUNC_CODE_PATH}



# Install common libraries
RUN apt-get update && apt-get install -y \
        imagemagick=8:6.8.9.9-5+deb8u11 \
        libopencv-dev=2.4.9.1+dfsg-1+deb8u1 \
        fonts-wqy-zenhei=0.9.45-6 \
        fonts-wqy-microhei=0.2.0-beta-2

# Suppress opencv error: "libdc1394 error: Failed to initialize libdc1394"
RUN ln /dev/null /dev/raw1394

# Install third party libraries for user function
RUN npm install --global --unsafe-perm \
        --registry http://registry.npm.taobao.org \
        co@4.6.0 \
        gm@1.23.0 \
        ali-oss@4.10.1 \
        aliyun-sdk@1.10.12 \
        @alicloud/fc@1.2.2 \
        opencv@6.0.0 \
        tablestore@4.0.4 \
        @alicloud/fc2@2.0.0

RUN npm cache clean --force

# Remove package.json
RUN rm -f package.json

# Generate usernames
RUN for i in $(seq 10000 10999); do \
        echo "user$i:x:$i:$i::/tmp:/usr/sbin/nologin" >> /etc/passwd; \
    done

# Start a shell by default
CMD ["bash"]
