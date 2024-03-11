# Helm Charts
* [github-actions-runner](./github-actions-runner/)

# Helm Repository
The above charts are made available by github pages, which is configured against the main branch of this repository

To add this repository to helm use the following commands
```bash
helm repo add lscsde https://lsc-sde.github.io/iac-helm-repository/
helm repo update
```

## Adding to the repository
To package up a helm chart use the following command

```bash
helm package ./<directory-name>/ 
helm repo index ./
```

This should generate a new helm chart package as a tgz file and an updated version of the helm repo index.

The package and index file should be added and checked into git repository under this folder. When pushed to the main branch, the asset should become available to the internet.