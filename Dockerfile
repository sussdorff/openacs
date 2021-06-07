FROM oupfiz5/naviserver-s6:latest

RUN mkdir -p /var/www

WORKDIR /var/www

RUN wget --quiet https://openacs.org/projects/openacs/download/download/openacs-5.9.1-core.tar.gz \
    && tar xfz openacs-5.9.1-core.tar.gz \
    && mv openacs-5.9.1 openacs \
    && chown -R nsadmin:nsadmin /var/www/openacs

COPY openacs-config.tcl /usr/local/ns/conf/openacs-config.tcl
COPY wait-for-postgres.sh /usr/local/ns/bin/wait-for-postgres.sh
COPY openacs-test.tcl /var/www/openacs/www/SYSTEM/openacs-test.tcl

WORKDIR /var/www/openacs
EXPOSE 8000

ENTRYPOINT [ "/usr/local/ns/bin/wait-for-postgres.sh" ]
