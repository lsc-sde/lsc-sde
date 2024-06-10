#!/bin/bash

mkdir -p /usr/lib/jupyterhub/bin
mkdir -p /usr/lib/jupyterhub/etc
mkdir -p /usr/lib/jupyterhub/work
chmod 0777 /usr/lib/jupyterhub/work

cat <<EOF > /usr/lib/jupyterhub/etc/environment
HELM_REPOSITORY="${HELMREPOSITORY}"
NAMESPACE="${NAMESPACE}"
CHART_NAME="${CHARTNAME}"
CHART_VERSION="${CHARTVERSION}"
IMAGE_NAME="${IMAGENAME}"
IMAGE_TAG="${IMAGETAG}"
HUB_DOCKER_IMAGE_DEFINITION="${HUBDOCKERIMAGEDEFINITION}"
ANALYTICSWORKSPACE_HELM_CHART="${ANALYTICSWORKSPACEHELMCHART}"
EOF

cp -R ./bin /usr/lib/jupyterhub/

ln -s /usr/lib/jupyterhub/bin/setup-jupyterhub.sh /bin/setup-jupyterhub

pip install kubernetes_asyncio
pip install lscsde_workspace_mgmt
pip install jupyterhub-kubespawner
pip install pytest
pip install pytest-asyncio
pip install build
pip install twine
exit 0