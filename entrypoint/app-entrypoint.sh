#!/bin/bash

set -e

if [ "$1" = '/bin/bash' ]
then
  echo "Entering BASH"
fi

exec "$@"
