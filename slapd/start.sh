#!/bin/sh
# If no slapd.conf file (i.e. first install), copy over sample config
if [ ! -f "/etc/openldap/slapd.conf" ]; then
  cp -r /etc/openldap/.slapd.orig/* /etc/openldap/
fi
exec /usr/sbin/slapd -d 1 -h "ldap://slapd:9000" -g ldap -u ldap
tail -f /dev/null
