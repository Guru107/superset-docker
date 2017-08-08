FROM python:3.4-alpine
ARG PANDAS_VERSION=0.20.3

COPY superset /usr/local/bin

RUN chmod +x /usr/local/bin/superset-init /usr/local/bin/superset-example && \
	apk add --no-cache g++ && \
	apk add --no-cache --virtual .build-deps cyrus-sasl-dev libldap openssl-dev libffi-dev && \
	ln -s /usr/include/locale.h /usr/include/xlocale.h && \
	pip3 install --upgrade setuptools && \
	pip3 install numpy==1.13.1 && \
	pip3 install pandas==${PANDAS_VERSION} && \
	pip3 install superset && \
	apk del .build-deps

EXPOSE 8088
HEALTHCHECK --interval=5m --timeout=3s CMD curl -f http://localhost:8088/health
ENTRYPOINT ["superset"]
CMD ["runserver"]