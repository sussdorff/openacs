FROM sussdorff/naviserver


RUN apt-get update && apt-get install cvs -y && mkdir -p /var/www
RUN cvs -q -d:pserver:anonymous@cvs.openacs.org:/cvsroot checkout -r oacs-5-10 acs-core && mv openacs-4 /var/www/openacs
RUN mkdir -p /var/www/openacs/log

WORKDIR /var/www/openacs/packages

RUN cvs -q -d:pserver:anonymous@cvs.openacs.org:/cvsroot -q checkout -r oacs-5-10 xotcl-all \
    && cvs -q -d:pserver:anonymous@cvs.openacs.org:/cvsroot -q checkout -r oacs-5-10 xowf \
    && cvs -q -d:pserver:anonymous@cvs.openacs.org:/cvsroot -q checkout -r oacs-5-10 acs-developer-support ajaxhelper \
    && cvs -q -d:pserver:anonymous@cvs.openacs.org:/cvsroot -q checkout -r oacs-5-10 openacs-4/packages/richtext-ckeditor4 \
    && mv openacs-4/packages/richtext-ckeditor4 . && rm -rf openacs-4 \
    && cd /var/www/openacs && rm -rf openacs-4 \
    && mkdir -p /var/www/openacs/www/admin && cp /usr/local/ns/pages/nsstats.tcl /var/www/openacs/www/admin/nsstats.tcl \
    && chown -R nsadmin.nsadmin /var/www/openacs


COPY openacs-config.tcl /usr/local/ns/conf/openacs-config.tcl
COPY wait-for-postgres.sh /usr/local/ns/bin/wait-for-postgres.sh
COPY openacs-test.tcl /var/www/openacs/www/SYSTEM/openacs-test.tcl

WORKDIR /var/www/openacs
EXPOSE 8000

ENTRYPOINT [ "/usr/local/ns/bin/wait-for-postgres.sh" ]
