FROM ghcr.io/linuxserver/baseimage-alpine:3.15

# set version label
ARG BUILD_DATE
ARG VERSION
ARG NZBHYDRA2_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nemchik"

# environment settings
ENV NZBHYDRA2_RELEASE_TYPE="Release"

RUN \
  echo "**** install packages ****" && \
  apk add -U --no-cache --virtual=build-dependencies \
    unzip && \
  apk add -U --no-cache \
    curl \
    jq \
    openjdk11-jre-headless \
    python3 && \
  echo "**** install nzbhydra2 ****" && \
  if [ -z ${NZBHYDRA2_RELEASE+x} ]; then \
    NZBHYDRA2_RELEASE=$(curl -sX GET "https://api.github.com/repos/theotherp/nzbhydra2/releases/latest" \
    | jq -r .tag_name); \
  fi && \
  NZBHYDRA2_VER=${NZBHYDRA2_RELEASE#v} && \
  curl -o \
  /tmp/nzbhydra2.zip -L \
    "https://github.com/theotherp/nzbhydra2/releases/download/v${NZBHYDRA2_VER}/nzbhydra2-${NZBHYDRA2_VER}-linux.zip" && \
  mkdir -p /app/nzbhydra2/bin && \
  unzip /tmp/nzbhydra2.zip -d /app/nzbhydra2/bin && \
  rm -rf \
    /app/nzbhydra2/bin/upstart/ \
    /app/nzbhydra2/bin/rc.d/ \
    /app/nzbhydra2/bin/sysv/ \
    /app/nzbhydra2/bin/systemd/ && \
  chmod +x /app/nzbhydra2/bin/nzbhydra2wrapperPy3.py && \
  echo -e "ReleaseType=${NZBHYDRA2_RELEASE_TYPE}\nPackageVersion=${VERSION}\nPackageAuthor=linuxserver.io" > /app/nzbhydra2/package_info && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 5076
VOLUME /config
