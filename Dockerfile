FROM python:3.4-alpine
ARG PANDAS_VERSION=0.20.3
RUN apk add --no-cache g++ && \
	apk add --no-cache --virtual .build-deps cyrus-sasl-dev libldap openssl-dev libffi-dev && \
	ln -s /usr/include/locale.h /usr/include/xlocale.h && \
	pip3 install --upgrade setuptools && \
	pip3 install numpy==1.13.1 && \
	pip3 install pandas==${PANDAS_VERSION} && \
	pip3 install superset && \
	apk del .build-deps

EXPOSE 8088
HEALTHCHECK CMD ["curl", "-f", "http://localhost:8088/health"]
ENTRYPOINT ["superset"]
CMD ["runserver"]