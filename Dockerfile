FROM sussdorff/naviserver

RUN mkdir -p /var/www

WORKDIR /var/www

RUN wget --quiet https://openacs.org/projects/openacs/download/download/openacs-5.9.1-core.tar.gz \
    && tar xfz openacs-5.9.1-core.tar.gz \
    && mv openacs-5.9.1 openacs \
    && chown -R nsadmin:nsadmin /var/www/openacs

COPY openacs-config.tcl /usr/local/ns/conf/openacs-config.tcl

WORKDIR /var/www/openacs

ENTRYPOINT ["/usr/local/ns/bin/nsd"]
CMD ["-i", "-u","nsadmin","-g","nsadmin","-t", "/usr/local/ns/conf/openacs-config.tcl"]