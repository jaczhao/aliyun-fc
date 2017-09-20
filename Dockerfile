FROM reg.docker.alibaba-inc.com/serverless/fc-cagent-java:8u131-dev-v5

MAINTAINER alibaba-serverless-lambda

# Environment variables can be overwritten by running
# $ docker run --env <key>=<value>
# Expose the port number.
EXPOSE ${FC_SERVER_PORT}

# Function configuration.
ENV FC_FUNC_CODE_PATH=/code/ \
    FC_RUNTIME_ROOT_PATH=${FC_SERVER_PATH}/bootstrap \
    FC_RUNTIME_SYSTEM_PATH=${FC_SERVER_PATH}

# Create function directories.
RUN mkdir -p \
    ${FC_RUNTIME_LOG_PATH} \
    ${FC_FUNC_CODE_PATH} \
    ${FC_RUNTIME_SYSTEM_PATH}

# Change work directory.
WORKDIR ${FC_FUNC_CODE_PATH}