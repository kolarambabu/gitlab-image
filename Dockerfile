FROM openjdk:17-jdk-bullseye

RUN groupadd gitlab && \
    useradd -s /bin/bash -g gitlab gitlab

ARG AWSCLI_VERSION=2.24.5
ARG HELM_VERSION=3.17.0
LABEL maintainer=rambabu.2002@gmail.com

RUN apt-get update && \
    apt-get install \
        curl \
        bash \
        git \
        openssh-client \
        openssl \
        procps \
        groff \
        less \
        maven \
        jq \
        zip \
        python3 \
        python3-pip -y && \
    apt-get clean

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
COPY ./aws-cli.sh ./
RUN ./aws-cli.sh ${AWSCLI_VERSION}

RUN if $(uname -a | grep -q 'aarch'); then \
         export ARCH="arm64"; \
       else \
         export ARCH="amd64"; \
    fi \
    && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh --version ${HELM_VERSION} \
    && curl -o kubectl "curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.7/2024-12-12/bin/linux/${ARCH}/kubectl" \
    && chmod +x ./kubectl \
    && cp ./kubectl /usr/local/bin/kubectl     
