#!/bin/bash

mkdir -p /usr/lib/ohdsi/bin
mkdir -p /usr/lib/ohdsi/etc

cat <<EOF > /usr/lib/ohdsi/etc/environment
OHDSI_HELM_CHART_PATH="${PATHTOHELMCHART}"
OHDSI_NAMESPACE="${OHDSINAMESPACE}"
EOF

cp -R ./bin /usr/lib/ohdsi/

ln -s /usr/lib/ohdsi/bin/setup-ohdsi.sh /bin/setup-ohdsi

exit 0