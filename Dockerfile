FROM sussdorff/naviserver:4.99.24


RUN apt-get update && apt-get upgrade -y && apt-get install git -y && mkdir -p /var/www
RUN git clone -b oacs-5-10 https://github.com/openacs/openacs-core.git && mv openacs-core /var/www/openacs
RUN mkdir -p /var/www/openacs/log

WORKDIR /var/www/openacs/packages


RUN git clone -b oacs-5-10 https://github.com/openacs/xotcl-core.git && git clone -b oacs-5-10 https://github.com/openacs/xotcl-request-monitor.git \
    && git clone -b oacs-5-10 https://github.com/openacs/ajaxhelper \
    && git clone -b oacs-5-10 https://github.com/openacs/richtext-ckeditor4 

RUN mkdir -p /var/www/openacs/www/admin && cp /usr/local/ns/pages/nsstats.tcl /var/www/openacs/www/admin/nsstats.tcl \
    && chown -R nsadmin.nsadmin /var/www/openacs


COPY openacs-config.tcl /usr/local/ns/conf/openacs-config.tcl
COPY wait-for-postgres.sh /usr/local/ns/bin/wait-for-postgres.sh
COPY openacs-test.tcl /var/www/openacs/www/SYSTEM/openacs-test.tcl

WORKDIR /var/www/openacs
EXPOSE 8000

ENTRYPOINT [ "/usr/local/ns/bin/wait-for-postgres.sh" ]
