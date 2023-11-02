#!/usr/bin/env bash

install_bat() {
	: "${BAT_VERSION:="0.24.0"}"
	BAT_URL="https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-v${BAT_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
	if ! command -v bat &>/dev/null; then
		pushd "$DOWNLOADS_DIR"
		curl -sSL "$BAT_URL" -o bat.tar.gz
		tar -xzvf bat.tar.gz
		mv "bat-v${BAT_VERSION}-x86_64-unknown-linux-gnu" bat
		mv bat "$BIN_DIR"
		popd
	fi
}

install_eza() {
	: "${EZA_VERSION:="0.15.1"}"
	EZA_URL="https://github.com/eza-community/eza/releases/download/v${EZA_VERSION}/eza_x86_64-unknown-linux-gnu.tar.gz"
	if ! command -v eza &>/dev/null; then
		pushd "$DOWNLOADS_DIR"
		curl -sSL "$EZA_URL" -o eza.tar.gz
		tar -xzvf eza.tar.gz
		mv eza "$BIN_DIR"
		popd
	fi
}

install_fd() {
	: "${FD_VERSION:="8.7.1"}"
	FD_URL="https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd-v${FD_VERSION}-x86_64-unknown-linux-musl.tar.gz"
	if ! command -v fd &>/dev/null; then
		pushd "$DOWNLOADS_DIR"
		curl -sSL "$FD_URL" -o fd.tar.gz
		tar -xzvf fd.tar.gz
		mv "fd-v${FD_VERSION}-x86_64-unknown-linux-musl/fd" "$BIN_DIR"
		popd
	fi
}

install_fzf() {
	if ! command -v fzf &>/dev/null; then
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		~/.fzf/install --bin --key-bindings --completion --no-update-rc
	fi
}

install_glow() {
	: "${GLOW_VERSION="1.5.1"}"
	GLOW_URL="https://github.com/charmbracelet/glow/releases/download/v${GLOW_VERSION}/glow_${GLOW_VERSION}_Linux_x86_64.tar.gz"
	if ! command -v glow &>/dev/null; then
		pushd "$(mktemp -d)"
		curl -sSL "$GLOW_URL" -o glow.tar.gz
		tar -xzvf glow.tar.gz
		mv glow "$BIN_DIR"
		popd
	fi
}

install_neofetch() {
	: "${NEOFETCH_VERSION="7.1.0"}"
	NEOFETCH_URL="https://github.com/dylanaraps/neofetch/archive/refs/tags/${NEOFETCH_VERSION}.tar.gz"
	if ! command -v neofetch &>/dev/null; then
		pushd "$DOWNLOADS_DIR"
		curl -sSL "$NEOFETCH_URL" -o "${NEOFETCH_VERSION}.tar.gz"
		tar -xzvf "${NEOFETCH_VERSION}.tar.gz"
		make -C "neofetch-${NEOFETCH_VERSION}" PREFIX="$BIN_DIR"/neofetch install
		popd
	fi

	if [ ! -f ~/.config/neofetch/config.conf ]; then
		mkdir -p ~/.config/neofetch/
		ln -s ~/.files/neofetch.conf ~/.config/neofetch/config.conf
	fi
}

install_jq() {
	: "${JQ_VERSION:="1.7"}"
	JQ_URL="https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64"
	if ! command -v jq &>/dev/null; then
		pushd "$DOWNLOADS_DIR"
		curl -sSL "$JQ_URL" -o jq
		chmod +x jq
		mv jq "$BIN_DIR"
		popd
	fi
}

install_pipes() {
	: "${PIPES_VERSION:="1.3.0"}"
	PIPES_URL="https://github.com/pipeseroni/pipes.sh/archive/refs/tags/v${PIPES_VERSION}.tar.gz"
	if ! command -v pipes.sh &>/dev/null; then
		pushd "$DOWNLOADS_DIR"
		curl -sSL "$PIPES_URL" -o "pipes-v${PIPES_VERSION}.tar.gz"
		tar -xzvf "pipes-v${PIPES_VERSION}.tar.gz"
		make -C "pipes.sh-$PIPES_VERSION" PREFIX="$BIN_DIR"/pipes.sh install
		popd
	fi
}

install_ripgrep() {
	: "${RIPGREP_VERSION:="13.0.0"}"
	RIPGREP_URL="https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl.tar.gz"
	if ! command -v rg &>/dev/null; then
		pushd "$DOWNLOADS_DIR"
		curl -sSL "$RIPGREP_URL" -o "ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl.tar.gz"
		tar -xzvf "ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl.tar.gz"
		mv "ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl/rg" "$BIN_DIR"
		popd
	fi
}

install_vivid() {
	: "${VIVID_VERSION:="0.9.0"}"
	VIVID_URL="https://github.com/sharkdp/vivid/releases/download/v${VIVID_VERSION}/vivid-v${VIVID_VERSION}-x86_64-unknown-linux-musl.tar.gz"
	if ! command -v vivid; then
		pushd "$(mktemp -d)"
		curl -sSL "$VIVID_URL" -o "vivid-v${VIVID_VERSION}-x86_64-unknown-linux-musl.tar.gz"
		tar -xzvf "vivid-v${VIVID_VERSION}-x86_64-unknown-linux-musl.tar.gz"
		mv "vivid-v${VIVID_VERSION}-x86_64-unknown-linux-musl/vivid" "$BIN_DIR"
		popd
	fi
}

install_yq() {
	: "${YQ_VERSION:="4.35.2"}"
	YQ_URL="https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_amd64"
	if ! command -v yq &>/dev/null; then
		curl -sSL "$YQ_URL" -o yq
		chmod +x yq
		mv yq "$BIN_DIR"
	fi
}

install_zoxide() {
	: "${ZOXIDE_VERSION:="0.9.2"}"
	ZOXIDE_URL="https://raw.githubusercontent.com/ajeetdsouza/zoxide/v${ZOXIDE_VERSION}/install.sh"
	if ! command -v z &>/dev/null; then
		pushd "$DOWNLOADS_DIR"
		curl -sS "$ZOXIDE_URL" | bash
		popd
	fi
}
