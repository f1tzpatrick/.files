#!/bin/bash

: "${BIN_DIR:="$HOME/.local/bin"}"
: "${DOWNLOADS_DIR:="$(mktemp -d)"}"

source ~/.files/installs/common.sh

install_utils() {
	. ~/.files/installs/util.sh

	set -x
	mkdir -p "$BIN_DIR"
	mkdir -p "$DOWNLOADS_DIR"
	set +x

	parallelize '
	   install_bat
	   install_eza
	   install_fd
	   install_fzf
	   install_glow
	   install_neofetch
	   install_jq
	   install_pipes
	   install_ripgrep
	   install_vivid
	   install_yq
	   install_zoxide
	 '
}
