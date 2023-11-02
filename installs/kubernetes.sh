#!/usr/bin/env/bash

install_clusterctl() {
	: "${CLUSTERCTL_VERSION:="1.5.3"}"
	CLUSTERCTL_URL="https://github.com/kubernetes-sigs/cluster-api/releases/download/v${CLUSTERCTL_VERSION}/clusterctl-linux-amd64"
	if ! command -v clusterctl &>/dev/null; then
		pushd "$DOWNLOADS_DIR"
		curl -sSL "$CLUSTERCTL_URL" -o clusterctl
		chmod +x clusterctl
		sudo mv clusterctl-linux-amd64 "$BIN_DIR"
		popd
	fi
}

install_docker() {
	if ! command -v docker &>/dev/null; then
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
		sudo apt-get install -y docker-ce bridge-utils docker-ce-cli containerd.io
	fi
	sudo usermod -aG docker "$USER"
	echo "'$USER' was added to the docker group. Please log out and back in for change to take effect"
}

install_helm() {
	: "${HELM_VERSION:="3.10.3"}"
	curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
	chmod 700 get_helm.sh
	if [ "$HELM_VERSION" == "" ]; then
		./get_helm.sh
	else
		./get_helm.sh --version "v$HELM_VERSION"
	fi
	rm get_helm.sh
}

install_k9s() {
	: "${K9S_VERSION:="0.27.4"}"
	K9S_URL="https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_amd64.tar.gz"
	K9S_THEME_URL="https://raw.githubusercontent.com/derailed/k9s/v${K9S_VERSION}/skins/gruvbox-dark.yml"
	if ! command -v k9s &>/dev/null; then
		pushd "$DOWNLOADS_DIR"
		curl -sSL "$K9S_URL" -o k9s.tar.gz
		mv k9s "$BIN_DIR"

		mkdir -p ~/.config/k9s/
		curl -sSL "$K9S_THEME_URL" -o ~/.config/k9s/skin.yml
		if [ -f ~/.config/k9s/config.yml ]; then
			yq -i '.k9s.headless = true' ~/.config/k9s/config.yml
			yq -i '.k9s.noExitOnCtrlC = true' ~/.config/k9s/config.yml
		fi
		popd
	fi
}

install_kind() {
	: "${KIND_VERSION:="0.20.0"}"
	KIND_URL="https://github.com/kubernetes-sigs/kind/releases/download/v${KIND_VERSION}/kind-linux-amd64"
	if ! command -v kind &>/dev/null; then
		pushd "$DOWNLOADS_DIR"
		curl -sSL "$KIND_URL" -o kind
		chmod +x ./kind
		mv kind "$BIN_DIR"
		popd
	fi
}

install_kubebuilder() {
	: "${KUBEBUILDER_VERSION:=$(go env GOOS)}"
	if ! command -v kubebuilder &>/dev/null; then
		wget -qcO kubebuilder https://go.kubebuilder.io/dl/latest/${KUBEBUILDER_VERSION}/$(go env GOARCH)
		chmod +x kubebuilder && sudo mv kubebuilder /usr/local/bin/
	fi
}

install_kubectl() {
	: "${KUBERNETES_VERSION:=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)}"
	if ! command -v kubectl &>/dev/null; then
		sudo curl -L "https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
		sudo chmod +x /usr/local/bin/kubectl
		kubectl version --short --client
	fi
}

install_kubectx() {
	: "${KUBECTX_VERSION:="v0.9.5"}"
	KUBECTX_URL="https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubectx_${KUBECTX_VERSION}_linux_x86_64.tar.gz"
	KUBENS_URL="https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubens_${KUBECTX_VERSION}_linux_x86_64.tar.gz"
	pushd "$DOWNLOADS_DIR"
	if ! command -v kubectx &>/dev/null; then
		curl -sSL "$KUBECTX_URL" -o kubectx.tar.gz
		tar -xzxf kubectx.tar.gz
		mv "kubectx_v${KUBECTX_VERSION}_linux_x86_64/kubectx" "$BIN_DIR"
	fi

	if ! command -v kubens &>/dev/null; then
		curl -sSL "$KUBENS_URL" -o kubens.tar.gz
		tar -xzxf kubens.tar.gz
		mv "kubens_v${KUBENS_VERSION}_linux_x86_64/kubens" "$BIN_DIR"
	fi
}

install_kustomize() {
	if ! command -v kustomize &>/dev/null; then
		curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
		sudo mv ./kustomize /usr/local/bin/kustomize
	fi
}

