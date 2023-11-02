#!/usr/bin/env/bash

: "${BIN_DIR:="$HOME/.local/bin"}"
: "${DOWNLOADS_DIR:="$(mktemp -d)"}"

source ~/.files/installs/common.sh

install_utils() {
	. ~/.files/installs/utils.sh

	mkdir -p "$BIN_DIR"
	mkdir -p "$DOWNLOADS_DIR"

	parallelize '
	   install_bat
     install_bottom
     install_duf
     install_dust
	   install_eza
	   install_fd
	   install_fzf
	   install_glow
     install_lazygit
	   install_neofetch
	   install_jq
	   install_pipes
	   install_ripgrep
	   install_vivid
	   install_yq
	   install_zoxide
	 '
}

install_kube_utils() {
	. ~/.files/installs/kubernetes.sh

	mkdir -p "$BIN_DIR"
	mkdir -p "$DOWNLOADS_DIR"

	parallelize '
    install_clusterctl
    install_docker
    install_helm
    install_k9s
    install_kind
    install_kubebuider
    install_kubectx
    install_kustomize
  '
}

install_languages() {
	. ~/.files/installs/languages.sh

	mkdir -p "$BIN_DIR"
	mkdir -p "$DOWNLOADS_DIR"

	parallelize '
    install_go
    install_rust
    install_python
    install_nodejs
  '
}
