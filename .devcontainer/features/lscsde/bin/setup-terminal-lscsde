#!/bin/bash

. /etc/lscsde/setup/environment

echo "Setting up secrets for LSC-SDE"
if [ ! -d "${SECRETS_PATH}" ]; then
    echo "Warning!: Secrets folder is not present, this should be located in ./.devcontainer/k3d/volume/secrets"
fi

if [ ! -f "${SECRETS_PATH}/PatToken" ]; then
    echo "Warning!: Secret PatToken is not present, please ensure that it is present in the secrets folder"
fi
PAT_TOKEN=$(cat "${SECRETS_PATH}/PatToken")
cat <<EOF >> ~/.bashrc
export TF_VAR_pat_token="${PAT_TOKEN}"
EOF