# vim:set et ts=2 sw=2 syntax=dockerfile:
FROM docker.xlands-inc.com/baoyu/debian
MAINTAINER djluo <dj.luo@baoyugame.com>

RUN export http_proxy="http://172.17.42.1:8080/" \
    && export DEBIAN_FRONTEND=noninteractive     \
    && apt-get update \
    && apt-get install -y libwrap0 db-util \
    && apt-get clean \
    && url="http://172.17.42.1:8080/dante/dante-server_1.4.1-1_amd64.deb" \
    && curl -sLo  /dante.deb $url \
    && dpkg -i    /dante.deb \
    && /bin/rm -f /dante.deb \
    && unset url \
    && /bin/rm -rf /etc/init.d/danted \
    && find var/lib/apt -type f -exec rm -fv {} \; \
    && /bin/rm -rf /usr/share/doc/dante-server \
    && /bin/rm -rf /usr/share/man/man8/danted.8.gz \
    && /bin/rm -rf /usr/share/man/man5/danted.conf.5.gz

COPY ./entrypoint.pl      /entrypoint.pl
COPY ./conf/danted.pam    /etc/pam.d/danted
COPY ./conf/danted.conf   /etc/danted-example.conf
COPY ./bin/add-user       /usr/bin/add-user

ENTRYPOINT ["/entrypoint.pl"]
CMD        ["/usr/sbin/danted", "-f", "/etc/danted/danted.conf"]
