#!/bin/bash

cp ./bin/* /bin/

sh -c 'curl -s https://fluxcd.io/install.sh | FLUX_VERSION=2.0.0 bash'

exit 0