# This dockerfile uses the ubuntu image
# VERSION 1 - EDITION 1
# Author: Huoty <sudohuoty@gmail.com>
# Command format: Instruction [arguments / command] ..

# Base image to use, this must be set as the first line
FROM ubuntu

# Maintainer: docker_user <docker_user at email.com> (@docker_user)
MAINTAINER Huoty sudohuoty@gmail.com

# Commands to update the image
# Add Tini
#ENV TINI_VERSION v0.9.0
#ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
ADD tini/tini /bin/tini
RUN chmod +x /bin/tini
ENTRYPOINT ["/bin/tini", "--"]

# Add XX-Net
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
RUN apt-get update && apt-get install --no-install-recommends -y \
python \
python-openssl \
libffi-dev \
python-gtk2 \
python-appindicator \
libnss3-tools

# Clean apt cache
RUN apt-get clean

# Copy file to container
RUN mkdir -p /opt/XX-Net
COPY code /opt/XX-Net/code
COPY launcher /opt/XX-Net/launcher
COPY data /opt/XX-Net/data
ADD start /opt/XX-Net/start
RUN chmod +x /opt/XX-Net/start

# Commands when creating a new container
WORKDIR /opt/XX-Net/
CMD ["sh", "/opt/XX-Net/start"]
