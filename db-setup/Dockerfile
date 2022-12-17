FROM openjdk:8-alpine
WORKDIR /usr/src/app

ARG LB_VERSION=${MY_LIQUIBASE_VERSION:-4.10.0}
ENV CLEAR_CHECK_SUMS=${CLEAR_CHECK_SUMS:-false}
ENV DB_CONNECTOR_VERSION=${DB_CONNECTOR_VERSION:-42.3.3}
ENV BUILD_DEPS="gettext"
ENV RUNTIME_DEPS="libintl"

COPY . ./
RUN apk update && \
    apk add wget bash --no-cache && \
    apk add --update $RUNTIME_DEPS && \
    apk add --virtual build_deps $BUILD_DEPS &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps && \
    wget -q -O liquibase.zip https://github.com/liquibase/liquibase/releases/download/v$LB_VERSION/liquibase-$LB_VERSION.zip && \
    unzip -q -d . liquibase.zip && \
    rm liquibase.zip && \
    chmod +x liquibase* && \
    chmod +x *_database.sh && \
    mv postgresql-$DB_CONNECTOR_VERSION.jar /usr/src/app/lib/postgresql-connector.jar && \
    apk del wget

CMD [ "/bin/sh", "update_database.sh" ]