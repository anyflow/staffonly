# Stage 1: Base image with kubectl and istioctl
FROM nicolaka/netshoot:latest

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl

RUN echo "source <(kubectl completion zsh)" >> ~/.zshrc && \
    echo "alias k=kubectl" >> ~/.zshrc

# Install istioctl
RUN curl -L https://istio.io/downloadIstio | sh - && \
    mv istio-1.25.2/bin/istioctl /usr/local/bin/istioctl && \
    cp istio-1.25.2/tools/_istioctl ~/_istioctl && \
    rm -rf istio-1.25.2

RUN echo "source <(istioctl completion zsh)" >> ~/.zshrc && \
    echo "alias i=istioctl" >> ~/.zshrc

# Install k9s
RUN curl -sS https://webinstall.dev/k9s | bash