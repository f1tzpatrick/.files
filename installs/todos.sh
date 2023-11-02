#!/usr/bin/env bash

install_base() {
	sudo apt-get update
	sudo apt-get install -y \
		apt-transport-https \
		software-properties-common \
		ca-certificates \
		curl \
		make \
		wget \
		unzip \
		gnupg-agent \
		build-essential \
		libevent-dev \
		ncurses-dev \
		libssl-dev \
		pkg-config
}

install_az() {
	if ! command -v az &>/dev/null; then
		curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
	fi
}

install_neovim() {
	: "${NEOVIM_VERSION:="0.9.0"}"
	if ! command -v nvim &>/dev/null; then
		pushd "$(mktemp -d)"
		wget -qc "https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim-linux64.tar.gz"
		tar -xzvf nvim-linux64.tar.gz nvim-linux64
		sudo mv nvim-linux64 /usr/local/nvim
		popd
		if [ ! -f ~/.config/nvim ]; then
			ln -s ~/.files/nvim ~/.config/nvim
		fi
	fi
}

install_shellcheck() {
	: "${SHELLCHECK_VERSION:="0.9.0"}"
	SHELLCHECK_URL="https://github.com/koalaman/shellcheck/releases/download/v${SHELLCHECK_VERSION}/shellcheck-v${SHELLCHECK_VERSION}.linux.x86_64.tar.xz"
	if ! command -v shellcheck &>/dev/null; then
		pushd "$DOWNLOADS_DIR"
		curl -sSL "$SHELLCHECK_URL" -o "shellcheck-v${SHELLCHECK_VERSION}.linux.x86_64.tar.xz"
		tar -xvf "shellcheck-v${SHELLCHECK_VERSION}.linux.x86_64.tar.xz"
		mv "shellcheck-v${SHELLCHECK_VERSION}/shellcheck" "$BIN_DIR"
		popd
	fi
}

install_tmux() {
	: "${TMUX_VERSION:="3.3a"}"
	TMUX_URL="https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz"
	if command -v tmux; then
		pushd "$DOWNLOADS_DIR"
		curl -sSL "$TMUX_URL" -o "tmux-${TMUX_VERSION}.tar.gz"
		tar -xzvf "tmux-${TMUX_VERSION}.tar.gz"
		pushd "tmux-${TMUX_VERSION}"
		./configure --prefix "$BIN_DIR"/tmux && make
		make install
		popd

		# Get the tmux plugin manager
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
		popd
	fi

	if [ ! -f ~/.tmux.conf ]; then
		ln -s ~/.files/tmux.conf ~/.tmux.conf
	fi
}

