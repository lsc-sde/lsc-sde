set -e

echo "Installing FluxCD 2..."
curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.0.0 bash
