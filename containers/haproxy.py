#!/usr/bin/env python2

import json
import urllib2
import hashlib
import StringIO
import signal
import os

from subprocess import call

HAPROXY_CONFIG = '/etc/haproxy/haproxy.cfg'
HAPROXY_PID_FILE = '/run/haproxy.pid'
PUPPET_PORT    = 8140
HAPROXY_HEADER = """
global
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

    stats socket /var/lib/haproxy/stats

defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000

frontend  puppet *:8140
    mode                        tcp
    default_backend             puppetmasters

backend puppetmasters
    mode        tcp
    option      ssl-hello-chk
"""

def get_slaves():
  mesosstate = json.load(urllib2.urlopen('http://localhost:5050/master/state.json'))

  for slave in mesosstate['slaves']:
    yield slave['pid'].split('@')[1].split(':')[0]

def configure_slaves(slaves):
  slave_count = 0
  config      = StringIO.StringIO()
  config.write(HAPROXY_HEADER)
  for slave in slaves:
    config.write("    server puppetmaster%i %s:8140 check\n" % (slave_count, slave ))

  config.write('\n')
  return config.getvalue()

def write_config(config):
  if hashlib.sha256(config).hexdigest() == haproxy_config_hash():
    return False

  with open(HAPROXY_CONFIG, 'w') as f:
    f.write(config)
  return True

def haproxy_config_hash():
  return hashlib.sha256(open(HAPROXY_CONFIG).read()).hexdigest()

def reload_haproxy(do_reload=False):
  if do_reload:
    call(["systemctl","reload","haproxy"])

# MAIN
#-----
reload_haproxy(write_config(configure_slaves(get_slaves())))
