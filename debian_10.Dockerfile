FROM debian:buster

#Docker RUN example, pass in the git-lfs checkout copy you are working with
LABEL RUN="docker run -v git-lfs-checkout-dir:/src -v repo_dir:/repo"

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
apt-get install -y gettext git dpkg-dev dh-golang asciidoctor curl

ARG GOLANG_VERSION=1.20.6
ARG GOLANG_SHA256=b945ae2bb5db01a0fb4786afde64e6fbab50b67f6fa0eb6cfa4924f16a7ff1eb
ARG GOLANG_ARCH=amd64

ENV GOROOT=/usr/local/go

RUN cd /usr/local && \
    curl -L -O https://golang.org/dl/go${GOLANG_VERSION}.linux-${GOLANG_ARCH}.tar.gz && \
    [ "$(sha256sum go${GOLANG_VERSION}.linux-${GOLANG_ARCH}.tar.gz | cut -d' ' -f1)" = "${GOLANG_SHA256}" ] && \
    tar zxf go${GOLANG_VERSION}.linux-${GOLANG_ARCH}.tar.gz && \
    ln -s /usr/local/go/bin/go /usr/bin/go && \
    ln -s /usr/local/go/bin/gofmt /usr/bin/gofmt

COPY debian_script.bsh /tmp/

CMD /tmp/debian_script.bsh
