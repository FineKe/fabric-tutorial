# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

ARG GO_VER=1.13.4
ARG ALPINE_VER=3.10

FROM golang:${GO_VER}-alpine${ALPINE_VER} as peer-base
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk add --no-cache tzdata jq

FROM golang:${GO_VER}-alpine${ALPINE_VER} as golang
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk add --no-cache \
	bash \
	gcc \
	git \
	make \
	musl-dev 
ADD . $GOPATH/src/github.com/hyperledger
WORKDIR $GOPATH/src/github.com/hyperledger/fabric

FROM golang as peer
ARG GO_TAGS=""
RUN make peer GO_TAGS=${GO_TAGS}

FROM peer-base
ENV FABRIC_CFG_PATH /etc/hyperledger/fabric
ENV CGO_ENABLED=0
VOLUME /etc/hyperledger/fabric
VOLUME /var/hyperledger
COPY --from=peer /go/src/github.com/hyperledger/fabric/build/bin /usr/local/bin
COPY --from=peer /go/src/github.com/hyperledger/fabric/sampleconfig/msp ${FABRIC_CFG_PATH}/msp
COPY --from=peer /go/src/github.com/hyperledger/core.yaml ${FABRIC_CFG_PATH}
COPY --from=peer /go/src/github.com/hyperledger/external-builder /etc/hyperledger/external-builder
EXPOSE 7051
CMD ["peer","node","start"]