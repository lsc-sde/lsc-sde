#!/bin/bash

. /usr/lib/ohdsi/etc/environment

echo "Installing Helm Chart from ${OHDSI_HELM_CHART_PATH} to namespace ${OHDSI_NAMESPACE}"
helm upgrade -i -n "${OHDSI_NAMESPACE}" ohdsi "${OHDSI_HELM_CHART_PATH}" --create-namespace
