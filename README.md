# lsc-sde
This is the default repository for the Secure Data Environment

To checkout the repositories, run the following command in the integrated terminal:

```bash
git clone https://github.com/lsc-sde/lsc-sde.git --recurse-submodules
cd lsc-sde
git submodule foreach "git switch main"
```

* [Developers Starter Guide](./Developers.md)
* [Docker Images](./docker/)
* [Helm Charts](./iac/helm/)
* [Flux Charts](./iac/flux/)
* [Terraform](./iac/k8s/)