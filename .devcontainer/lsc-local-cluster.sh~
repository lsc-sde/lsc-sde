LSCSDE_FLUX_REPO_URL="https://github.com/lsc-sde/iac-flux-lscsde"
LSCSDE_FLUX_REPO_BRANCH="release/0.1.338"
LSCSDE_FLUX_REPO_CLUSTER_PATH="./clusters/devcontainer-local"


LOCAL_SECRETS_DIR="$(pwd)/.devcontainer/k3d-volume/secrets"
K3S_CONFIG_CALICO="$(pwd)/.devcontainer/calico.yaml"
K3D_HOST_VOL_DIR="$(pwd)/.devcontainer/k3d-volume"

set -e

echo "Delete lscsde local cluster if exists..."
k3d cluster delete lscsde

if [ ! -f "${K3S_CONFIG_CALICO}" ]; then
  echo "ERROR: ${K3S_CONFIG_CALICO} file is missing. Ensure calico is set up (and flannel is disabled) for k3d."
  exit 1
fi

if [ ! -d "${LOCAL_SECRETS_DIR}" ]; then
  echo "ERROR: ${LOCAL_SECRETS_DIR} is missing. Ensure that you have included the lscsde secrets directory in .devcontainer/k3d-volume"
  exit 1
fi

echo "Create new lscsde local cluster..."

k3d cluster create lscsde -v "${K3D_HOST_VOL_DIR}:/var/lib/rancher/k3s/storage@all" \
                             --k3s-arg "--disable=traefik@server:*" \
                             --k3s-arg '--flannel-backend=none@server:*' \
                             -v "${K3S_CONFIG_CALICO}:/var/lib/rancher/k3s/server/manifests/calico.yaml" --wait \
                             --k3s-arg '--disable-network-policy'  --no-lb

echo "Determining metallb loadbalancer IP range..."
cidr_block=$(docker network inspect k3d-lscsde | jq '.[0].IPAM.Config[0].Subnet' | tr -d '"')
cidr_base_addr=${cidr_block%???}
ingress_first_addr=$(echo $cidr_base_addr | awk -F'.' '{print $1,$2,255,0}' OFS='.')
ingress_last_addr=$(echo $cidr_base_addr | awk -F'.' '{print $1,$2,255,255}' OFS='.')
ingress_range=$ingress_first_addr-$ingress_last_addr

echo "Deploying metallb loadbalancer to lscsde cluster..."
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


kubectl cluster-info

echo "Add flux controllers to cluster..."
flux install

echo "Creating lscsde and lscsde-config cluster namespaces..."
kubectl create namespace lscsde
kubectl create namespace lscsde-config

echo "Create flux git source for lscsde with repo ${LSCSDE_FLUX_REPO_URL} from branch ${LSCSDE_FLUX_REPO_BRANCH}..."
flux create source git lscsde --url="${LSCSDE_FLUX_REPO_URL}" --branch="${LSCSDE_FLUX_REPO_BRANCH}" --namespace=lscsde

echo "Create lscsde cluster config for cluster ${LSCSDE_FLUX_REPO_CLUSTER_PATH}..."
flux create kustomization lscsde-cluster-config --source="GitRepository/lscsde" --namespace=lscsde --path="${LSCSDE_FLUX_REPO_CLUSTER_PATH}" --interval=1m --prune=true --health-check-timeout=2m --wait=false