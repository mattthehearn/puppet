#!/usr/bin/bash

PUPPET=/usr/local/bin/puppet
WORKDIR=/var/lib/jenkins/git/puppet

echo "Hi there!  I'm running as the result of a jenkins build!"
#echo "What's my user id?  Let's have a look see..."
#/usr/bin/id

echo "Running a puppet parser validate on all the *pp files I can find in here..."
ERRCT=$(/usr/bin/find ${WORKDIR} -name "*pp" -exec ${PUPPET} parser validate {} \; 2>&1 | /bin/grep Error | /bin/wc -l)
RC=$?
echo "Return code: ${RC} Error count: ${ERRCT}"

if [ $((${ERRCT} + ${RC})) -gt 0 ]
then
  echo "There were errors!  Crap!  Bailing out..."
  exit 1
fi

echo "Okay, I'm done!  Thanks for running me!"
