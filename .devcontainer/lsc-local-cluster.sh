set -e

echo "Delete lscsde local cluster if exists..."
k3d cluster delete lscsde

echo "Create new lscsde local cluster..."
k3d cluster create lscsde #> lscsde-k3d.log 2>&1
kubectl cluster-info

echo "Add flux operators to cluster..."
flux install