#!/bin/bash

# check arg0: dir for keys
[ -z "$1" ] && echo "Please specify directory for key generation" && exit 1
KEYSDIR="$1"

# set umask
umask 0022

# create directory tree if it does not exist
[ ! -d "$KEYSDIR" ] && mkdir -p $KEYSDIR

#
# functions stolen from CentOS 6 sshd init script
#

# Some functions to make the below more readable
KEYGEN=/usr/bin/ssh-keygen
RSA1_KEY=$1/ssh_host_key
RSA_KEY=$1/ssh_host_rsa_key
DSA_KEY=$1/ssh_host_dsa_key

# source function library
. /etc/rc.d/init.d/functions

fips_enabled() {
  if [ -r /proc/sys/crypto/fips_enabled ]; then
    cat /proc/sys/crypto/fips_enabled
  else  
    echo 0
  fi
}

do_rsa1_keygen() {
  if [ ! -s $RSA1_KEY -a `fips_enabled` -eq 0 ]; then
    echo -n $"Generating SSH1 RSA host key: "
    rm -f $RSA1_KEY
    if test ! -f $RSA1_KEY && $KEYGEN -q -t rsa1 -f $RSA1_KEY -C '' -N '' >&/dev/null; then
      chmod 600 $RSA1_KEY
      chmod 644 $RSA1_KEY.pub
      success $"RSA1 key generation"
      echo
    else  
      failure $"RSA1 key generation"
      echo
      exit 1
    fi
  fi
}

do_rsa_keygen() {
  if [ ! -s $RSA_KEY ]; then
    echo -n $"Generating SSH2 RSA host key: "
    rm -f $RSA_KEY
    if test ! -f $RSA_KEY && $KEYGEN -q -t rsa -f $RSA_KEY -C '' -N '' >&/dev/null; then
      chmod 600 $RSA_KEY
      chmod 644 $RSA_KEY.pub
      success $"RSA key generation"
      echo
    else  
      failure $"RSA key generation"
      echo
      exit 1
    fi
  fi
}

do_dsa_keygen() {
  if [ ! -s $DSA_KEY ]; then
    echo -n $"Generating SSH2 DSA host key: "
    rm -f $DSA_KEY
    if test ! -f $DSA_KEY && $KEYGEN -q -t dsa -f $DSA_KEY -C '' -N '' >&/dev/null; then
      chmod 600 $DSA_KEY
      chmod 644 $DSA_KEY.pub
      success $"DSA key generation"
      echo
    else
      failure $"DSA key generation"
      echo
      exit 1
    fi
  fi
}

# main
do_rsa1_keygen
do_rsa_keygen
do_dsa_keygen
chmod -R 440 $KEYSDIR/*
echo "Success" && exit 0
