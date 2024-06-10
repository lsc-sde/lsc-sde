#!/bin/bash

. /usr/lib/jupyterhub/etc/environment

CURRENT_DATE=$(date '+%Y%m%d%H%M%S')
WORK_FOLDER="/usr/lib/jupyterhub/work/${CURRENT_DATE}"
CURRENT_FOLDER=$(pwd)

mkdir -p "${WORK_FOLDER}"

echo "Building docker image based on definition in: ${HUB_DOCKER_IMAGE_DEFINITION}"
cd "${HUB_DOCKER_IMAGE_DEFINITION}"
docker build . -t "${IMAGE_NAME}:${IMAGE_TAG}" "$@"

echo "pushing docker image ${IMAGE_NAME}:${IMAGE_TAG} to local registry"
docker push "${IMAGE_NAME}:${IMAGE_TAG}"

cd "${CURRENT_FOLDER}"

echo "Installing Helm Chart ${CHART_NAME}:${CHART_VERSION} from ${HELM_REPOSITORY} to namespace ${NAMESPACE}"
helm repo add jupyterhub "${HELM_REPOSITORY}"
helm repo update


install_cmd=( helm upgrade -i )
install_cmd+=( -n "${NAMESPACE}" )
install_cmd+=( jh-test )
install_cmd+=( "jupyterhub/${CHART_NAME}" )
install_cmd+=( --version ${CHART_VERSION} )
install_cmd+=( --create-namespace )
install_cmd+=( --set hub.image.name="${IMAGE_NAME}")
install_cmd+=( --set hub.image.tag="${IMAGE_TAG}")
install_cmd+=( --set hub.image.pullPolicy="Always")
echo "Executing ${install_cmd[@]}"
${install_cmd[@]}

helm upgrade -i -n awms-test awms-test "${ANALYTICSWORKSPACE_HELM_CHART}" --create-namespace

cd "${WORK_FOLDER}"
cat <<EOF > bindings.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: jh-test:awms-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: awms-test-admin
subjects:
- kind: ServiceAccount
  name: hub
  namespace: jh-test
EOF

kubectl apply -f bindings.yaml

cat <<EOF > pvc.yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: jupyter-default
provisioner: rancher.io/local-path
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
EOF

kubectl apply -f pvc.yaml

cat <<EOF > workspaces.yaml
apiVersion: xlscsde.nhs.uk/v1
kind: AnalyticsWorkspace
metadata:
  name: default-generic-workspace
  namespace: jh-test
  annotations:
    kustomize.toolkit.fluxcd.io/prune: disabled
spec:
  displayName: Default Generic Workspace
  description: |
    Basic environment for testing with Python R and Julia.
  
  validity:
    availableFrom: "2022-01-01"
    expires: "2030-01-01"
  
  jupyterWorkspace:
    image: lscsde/datascience-notebook-default:0.1.0
    persistentVolumeClaim: 
      name: jupyter-default-generic-workspace
EOF
kubectl apply -f workspaces.yaml

cat <<EOF > workspace-bindings.yaml
apiVersion: xlscsde.nhs.uk/v1
kind: AnalyticsWorkspaceBinding
metadata:
  name: default-generic-workspace-jovyan
  namespace: jh-test
  annotations:
    kustomize.toolkit.fluxcd.io/prune: disabled
spec:
  workspace: default-generic-workspace
  username: "jovyan"
  expires: "2030-01-01"
EOF
kubectl apply -f workspace-bindings.yaml

nohup kubectl port-forward svc/proxy-public -n jh-test 80:80 &
cd "${CURRENT_FOLDER}"

kubectl rollout restart -n jh-test deployments/hub
