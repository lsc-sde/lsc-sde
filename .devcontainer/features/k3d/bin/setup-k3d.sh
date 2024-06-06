#!/bin/bash

. /etc/k3d/setup/environment

CONFIG_CALICO="/etc/k3d/setup/calico.yaml"

configure_docker() {
    cat "${SECRETSPATH}/GitHubPatToken" | docker login --username $(cat "${SECRETSPATH}/GitHubUser") --password-stdin
}

configure_kalico() {
    if [ "${INSTALLCALICO}" == "true" ]; then
        if [ ! -f "${CONFIG_CALICO}" ]; then
            echo "ERROR: ${CONFIG_CALICO} file is missing. Ensure calico is set up (and flannel is disabled) for k3d."
            exit 1
        fi
    fi
}

install_k3d() {
    curl -sSL https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
}

create_k3d_cluster() {
    configure_kalico
    k3d registry delete --all
    k3d cluster delete --all

    mkdir -p /var/lib/rancher/k3s/storage

    k3d_install_cmd=(k3d cluster create ${CLUSTERNAME})
    k3d_install_cmd+=( --registry-create "${CLUSTERNAME}-registry" )
    k3d_install_cmd+=( -v "${HOSTVOLUMEPATH}:/var/lib/rancher/k3s/storage@all" )


    if [ "${DISABLETRAEFIK}" == "true" ]; then
        k3d_install_cmd+=( --k3s-arg "--disable=traefik@server:*" )
    fi

    if [ "${DISABLEFLANNEL}" == "true" ]; then
        k3d_install_cmd+=( --k3s-arg '--flannel-backend=none@server:*' )
    fi

    if [ "${INSTALLCALICO}" == "true" ]; then
        k3d_install_cmd+=( -v "${CONFIG_CALICO}:/var/lib/rancher/k3s/server/manifests/calico.yaml" )
    fi

    if [ "${DISABLELOADBALANCER}" == "true" ]; then
        k3d_install_cmd+=( --no-lb )
    fi

    k3d_install_cmd+=( --wait )

    echo "Executing ${k3d_install_cmd[@]}"
    ${k3d_install_cmd[@]}
}

configure_docker
install_k3d
create_k3d_cluster
exit $?