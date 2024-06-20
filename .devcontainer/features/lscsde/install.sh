#!/bin/bash

cp ./bin/* /bin/

mkdir -p /etc/lscsde/setup

cat <<EOF > /etc/lscsde/setup/environment
FLUX_REPO_URL="${FLUXREPOURL}"
FLUX_REPO_PATH="${FLUXREPOPATH}"
SECRETS_PATH="${SECRETSPATH}"
CORE_FLUX_WORKSPACE_FOLDER="${COREFLUXWORKSPACEFOLDER}"
EOF

mkdir -p /var/lib/rancher/k3s/storage
chown node:node /var/lib/rancher/k3s/storage

exit 0