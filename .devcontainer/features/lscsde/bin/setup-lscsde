#!/bin/bash

. /etc/lscsde/setup/environment

WORKING_FOLDER=$(pwd)
cd "${CORE_FLUX_WORKSPACE_FOLDER}"
FLUX_REPO_BRANCH=$(git branch --show-current)
cd "${WORKING_FOLDER}"

if [ ! -d "${SECRETS_PATH}" ]; then
  echo "ERROR: ${SECRETS_PATH} is missing. Ensure that you have included the lscsde secrets directory in .devcontainer/k3d/volume"
  exit 1
fi

echo "Creating lscsde and lscsde-config cluster namespaces..."
kubectl create namespace lscsde
kubectl create namespace lscsde-config

kubectl label ClusterRole/system:metrics-server app.kubernetes.io/managed-by=Helm
kubectl annotate ClusterRole/system:metrics-server meta.helm.sh/release-name=metrics-server meta.helm.sh/release-namespace=metrics-server

kubectl label ClusterRoleBinding/system:metrics-server app.kubernetes.io/managed-by=Helm
kubectl annotate ClusterRoleBinding/system:metrics-server meta.helm.sh/release-name=metrics-server meta.helm.sh/release-namespace=metrics-server

kubectl label ClusterRoleBinding/metrics-server:system:auth-delegator app.kubernetes.io/managed-by=Helm
kubectl annotate ClusterRoleBinding/metrics-server:system:auth-delegator meta.helm.sh/release-name=metrics-server meta.helm.sh/release-namespace=metrics-server

kubectl label -n kube-system RoleBinding/metrics-server-auth-reader app.kubernetes.io/managed-by=Helm
kubectl annotate -n kube-system RoleBinding/metrics-server-auth-reader meta.helm.sh/release-name=metrics-server meta.helm.sh/release-namespace=metrics-server

kubectl label APIService/v1beta1.metrics.k8s.io app.kubernetes.io/managed-by=Helm
kubectl annotate APIService/v1beta1.metrics.k8s.io meta.helm.sh/release-name=metrics-server meta.helm.sh/release-namespace=metrics-server

echo "Create flux git source for lscsde with repo ${FLUX_REPO_URL} from branch ${FLUX_REPO_BRANCH}..."
flux create source git lscsde --url="${FLUX_REPO_URL}" --branch="${FLUX_REPO_BRANCH}" --namespace=lscsde

echo "Create lscsde cluster config for cluster ${FLUX_REPO_PATH}..."
flux create kustomization lscsde-cluster-config --source="GitRepository/lscsde" --namespace=lscsde --path="${FLUX_REPO_PATH}" --interval=1m --prune=true --health-check-timeout=2m --wait=false