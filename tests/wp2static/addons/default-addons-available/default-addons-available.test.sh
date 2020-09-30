#!/bin/sh

echo "default Lokl setup"
. ./helpers/setup-lokl-default.sh

echo "listing WP2Static addons"
rm -f > /tmp/wp2static-addons-list.clioutput
wp wp2static addons list > /tmp/wp2static-addons-list.clioutput

cd "forcefail"

echo "comparing expected and actual results"
echo "using file to file cmp"
if cmp -s /tmp/wp2static-addons-list.clioutput ./tests/wp2static/addons/default-addons-available/output/default-addons-list.clioutput
then
  exit 0
fi

exit 1
