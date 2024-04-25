LSCSDE_FLUX_REPO_URL="https://github.com/lsc-sde/iac-flux-lscsde"
LSCSDE_FLUX_REPO_BRANCH="release/0.1.207"
LSCSDE_FLUX_REPO_CLUSTER_PATH="./clusters/local"

set -e

echo "Delete lscsde local cluster if exists..."
k3d cluster delete lscsde

echo "Create new lscsde local cluster..."
k3d cluster create lscsde #> lscsde-k3d.log 2>&1
kubectl cluster-info

echo "Add flux controllers to cluster..."
flux install

echo "Create lscsde and lscsde cluster namespaces..."
kubectl create namespace lscsde
kubectl create namespace lscsde-config

echo "Create flux git source for lscsde..."
flux create source git lscsde --url="${LSCSDE_FLUX_REPO_URL}" --branch="${LSCSDE_FLUX_REPO_BRANCH}" --namespace=lscsde

echo "Create lscsde-cluster-config kustomization (may take a few seconds)..."
flux create kustomization lscsde-cluster-config --source="GitRepository/lscsde" --namespace=lscsde --path="${LSCSDE_FLUX_REPO_CLUSTER_PATH}" --interval=1m --prune=true --health-check-timeout=2m --wait=false