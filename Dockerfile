FROM python:2.7

MAINTAINER alibaba-serverless-fc

# Server path.
ENV FC_SERVER_PATH=/var/fc/runtime/python2.7

# Function configuration.
ENV FC_FUNC_CODE_PATH=/code/ \
    FC_FUNC_LOG_PATH=/var/log/fc/

# Create directory.
RUN mkdir -p ${FC_SERVER_PATH}

# Change work directory.
WORKDIR ${FC_FUNC_CODE_PATH}

# Install imagemagick
RUN apt-get install -y imagemagick

# Install third party libraries for user function.
RUN pip install \
    oss2 \
    tablestore \
    wand

# Start a shell by default
CMD ["bash"]
