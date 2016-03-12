#!/usr/bin/bash

PUPPET=/usr/local/bin/puppet
WORKDIR=/var/lib/jenkins/git/puppet
#DESTDIR=/etc/puppetlabs/code
DESTDIR=/etc/puppetlabs/code/environments/production
BACKDIR=${WORKDIR}/codebackup

BACKFILEWARN=8

COPYDIRS="manifests modules"

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

CURBAKFILS=$(/bin/ls -1 ${BACKDIR}.tar.* | wc -l)
if [ ${CURBAKFILS} -gt ${BACKFILEWARN} ]
then
  echo "Hey, there are currently ${CURBAKFILS} backup files (copies of old code) in ${BACKDIR}, might be time to clean that up."
fi

echo "I'm going to make a quick backup of the current code so I can put it back in place if necessary..."
TARFILE="${BACKDIR}/code-$(date +%F-%T).tar"
/bin/tar cf ${TARFILE} ${DESTDIR}
/bin/gzip ${TARFILE}
echo "Done backing up old code:"
/bin/ls -l ${TARFILE}.gz

echo "Now to copy in the new code..."
for DIR in ${COPYDIRS}
do
  echo "bout to copy ${WORKDIR}/${DIR}/* ${DESTDIR}/${DIR}/..."
  /bin/cp -Rp ${WORKDIR}/${DIR}/* ${DESTDIR}/${DIR}/
  /bin/chown -R pe-puppet:pe-puppet ${DESTDIR}/${DIR}
done

echo "Copies are done, so I'ma run me a quick puppet agent -t and pick up the new configs, if any apply to the master..."


echo "Okay, I'm done!  Thanks for running me!"
