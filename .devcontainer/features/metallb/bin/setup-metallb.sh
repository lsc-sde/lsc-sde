#!/bin/bash

. /etc/k3d/setup/environment

echo "Determining metallb loadbalancer IP range..."
cidr_block=$(docker network inspect k3d-${CLUSTERNAME} | jq '.[0].IPAM.Config[0].Subnet' | tr -d '"')
cidr_base_addr=${cidr_block%???}
ingress_first_addr=$(echo $cidr_base_addr | awk -F'.' '{print $1,$2,255,0}' OFS='.')
ingress_last_addr=$(echo $cidr_base_addr | awk -F'.' '{print $1,$2,255,255}' OFS='.')
ingress_range=$ingress_first_addr-$ingress_last_addr

echo "Deploying metallb loadbalancer to ${CLUSTERNAME} cluster..."
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.5/config/manifests/metallb-native.yaml

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - $ingress_range
EOF