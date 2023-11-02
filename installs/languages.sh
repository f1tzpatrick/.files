#!/usr/bin/env bash

install_go() {
	: "${GO_VERSION:="1.19.4"}"
	: "${FORCE_GO_INSTALL:=false}"
	if ! command -v go &>/dev/null || $FORCE_GO_INSTALL; then
		sudo rm -rf /usr/local/go
		wget -qc "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz" -O - | sudo tar -xz -C /usr/local
	fi
}

install_nvm() {
  : "${NVM_VERSION:="0.39.5"}"
  if ! command -v nvm &>/dev/null; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash
  fi
}

install_nodejs() {
	: "${NODE_JS_VERSION="18.15.0"}"

  if ! command -v nvm &>/dev/null; then
    install_nvm
  fi

  if ! command -v node &>/dev/null; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install "$NODE_JS_VERSION"
    nvm use "$NODE_JS_VERSION"
  fi
}

install_pyenv() {
	if ! command -v pyenv &>/dev/null; then
		curl -s -S -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
	fi
}

install_python() {
	: "${PYTHON_VERSION:="3.10.2"}"

  if ! command -v pyenv &>/dev/null; then
    install_pyenv
  fi
  
  if ! command python &>/dev/null; then
    export PYENV_ROOT=~/.pyenv
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    pyenv install "$PYTHON_VERSION"
    pyenv global "$PYTHON_VERSION"
  fi
  
}

install_rust() {
	: "${COOL_CARGO:=false}"
	if ! command -v rustup &>/dev/null; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -q
		source ~/.cargo/env
	fi
	if $COOL_CARGO; then
		cargo install code-minimap tmux-sessionizer
		tms config --paths "$HOME"
	fi
}

