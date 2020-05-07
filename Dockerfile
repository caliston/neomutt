# run with DOCKER_BUILDKIT=1 docker build -t neomutt-builder -o out .

FROM debian:jessie AS neomutt-builder
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential libcomerr2 libgnutls28-dev libgpgme11-dev libgssapi-krb5-2 libidn11-dev libk5crypto3 libkrb5-dev liblua5.2-dev libncursesw5-dev libnotmuch-dev libsasl2-dev libtinfo-dev libtokyocabinet-dev libsasl2-modules locales mime-support xsltproc libxml2-utils docbook docbook-xml gettext
#VOLUME /build
WORKDIR /build
COPY . /build
RUN pwd
RUN ls -l
RUN ./configure --disable-doc && make

# export binary in output dir
FROM scratch AS export-stage
COPY --from=neomutt-builder /build/neomutt /

