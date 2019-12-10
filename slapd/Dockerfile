FROM alpine:3.8
RUN apk add --no-cache openldap openldap-back-mdb
# RUN apk add --no-cache openldap
ARG UID
ARG GID
RUN sed -i "s@^ldap.*@ldap:x:$UID:$GID:ldap:/var/lib/ldap:/sbin/nologin@" /etc/passwd
RUN sed -i "s@^ldap.*@ldap:x:$GID:ldap@" /etc/group
RUN install -o ldap -g ldap -d /run/openldap
RUN install -o ldap -g ldap -d /etc/ldap
RUN install -o ldap -g ldap -d /var/lib/ldap
RUN chown -R ldap:ldap /var/lib/openldap /var/lib/ldap /etc/openldap
COPY start.sh /start.sh
RUN chmod +x /start.sh
USER ldap
WORKDIR /var/lib/ldap
EXPOSE 9000/tcp
CMD ls -al /etc/
CMD exec /start.sh
# CMD ["/usr/sbin/slapd","-d","1","-h","ldap://slapd:9000","-g","ldap","-u","ldap","-f","/etc/slapd/openldap/slapd.conf"]
