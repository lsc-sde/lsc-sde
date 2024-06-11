#!/bin/bash

. /usr/lib/ohdsi/etc/environment

helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install traefik traefik/traefik -n traefik-v2 --create-namespace

echo "Installing Helm Chart from ${OHDSI_HELM_CHART_PATH} to namespace ${OHDSI_NAMESPACE}"
helm upgrade -i -n "${OHDSI_NAMESPACE}" ohdsi "${OHDSI_HELM_CHART_PATH}" --create-namespace --set ingressClass.isDefaultClass=false
