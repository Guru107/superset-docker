FROM python:3.4-alpine
ARG PANDAS_VERSION=0.20.3
RUN apk add --no-cache --virtual .build-deps g++ && \
	ln -s /usr/include/locale.h /usr/include/xlocale.h && \
	apk add --no-cache build-base cyrus-sasl-dev libldap openssl-dev libffi-dev && \
	pip3 install --upgrade setuptools && \
	pip3 install numpy==1.13.1 && \
	pip3 install pandas==${PANDAS_VERSION} && \
	pip3 install superset && \
	apk del .build-deps

EXPOSE 8088 