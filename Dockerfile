FROM sussdorff/naviserver:4.99.24


RUN apt-get update && apt-get upgrade -y && apt-get install git -y && apt-get autoremove && apt-get clean -y && mkdir -p /var/www \
    && git clone -b oacs-5-10 https://github.com/openacs/openacs-core.git && mv openacs-core /var/www/openacs \
    && mkdir -p /var/www/openacs/log \
    && cd /var/www/openacs/packages \
    && git clone -b oacs-5-10 https://github.com/openacs/xotcl-core.git && git clone -b oacs-5-10 https://github.com/openacs/xotcl-request-monitor.git \
    && git clone -b oacs-5-10 https://github.com/openacs/ajaxhelper \
    && git clone -b oacs-5-10 https://github.com/openacs/richtext-ckeditor4 \
    && mkdir -p /var/www/openacs/www/admin && cp /usr/local/ns/pages/nsstats.tcl /var/www/openacs/www/admin/nsstats.tcl \
    && chown -R nsadmin.nsadmin /var/www/openacs


COPY openacs-config.tcl /usr/local/ns/conf/openacs-config.tcl
COPY wait-for-postgres.sh /usr/local/ns/bin/wait-for-postgres.sh
COPY openacs-test.tcl /var/www/openacs/www/SYSTEM/openacs-test.tcl

WORKDIR /var/www/openacs
EXPOSE 8000

ENTRYPOINT [ "/usr/local/ns/bin/wait-for-postgres.sh" ]
