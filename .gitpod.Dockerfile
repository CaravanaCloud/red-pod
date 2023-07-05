# docker build --no-cache --progress=plain -f .gitpod.Dockerfile .
FROM gitpod/workspace-full

# System
RUN bash -c "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3EFE0E0A2F2F60AA"
RUN bash -c "echo 'deb http://ppa.launchpad.net/tektoncd/cli/ubuntu jammy main'|sudo tee /etc/apt/sources.list.d/tektoncd-ubuntu-cli.list"
RUN bash -c "sudo install-packages direnv gettext mysql-client gnupg golang"
RUN bash -c "sudo apt-get update"
RUN bash -c "sudo pip install --upgrade pip"

# UP
RUN bash -c "git clone https://github.com/CaravanaCloud/up.git /workspace/up"
RUN bash -c "cd /workspace/up && ./install_all.sh"
RUN bash -c "up"

# Java
ARG JAVA_SDK="17.0.7-amzn"
RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh \
    && sdk install java $JAVA_SDK \
    && sdk default java $JAVA_SDK \
    && sdk install quarkus \
    && sdk install maven \
    "

# OpenShift Installer
RUN bash -c "mkdir -p '/tmp/openshift-installer' \
    && wget -nv -O '/tmp/openshift-installer/openshift-install-linux.tar.gz' 'https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/openshift-install-linux.tar.gz' \
    && tar zxvf '/tmp/openshift-installer/openshift-install-linux.tar.gz' -C '/tmp/openshift-installer' \
    && sudo mv  '/tmp/openshift-installer/openshift-install' '/usr/local/bin/' \
    && rm '/tmp/openshift-installer/openshift-install-linux.tar.gz'\
    "
    
# Credentials Operator CLI
RUN bash -c "mkdir -p '/tmp/ccoctl' \
    && wget -nv -O '/tmp/ccoctl/ccoctl-linux.tar.gz' 'https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/ccoctl-linux.tar.gz' \
    && tar zxvf '/tmp/ccoctl/ccoctl-linux.tar.gz' -C '/tmp/ccoctl' \
    && sudo mv '/tmp/ccoctl/ccoctl' '/usr/local/bin/' \
    && rm '/tmp/ccoctl/ccoctl-linux.tar.gz'\
    "

# OpenShift CLI
RUN bash -c "mkdir -p '/tmp/oc' \
    && wget -nv -O '/tmp/oc/openshift-client-linux.tar.gz' 'https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/openshift-client-linux.tar.gz' \
    && tar zxvf '/tmp/oc/openshift-client-linux.tar.gz' -C '/tmp/oc' \
    && sudo mv '/tmp/oc/oc' '/usr/local/bin/' \
    && sudo mv '/tmp/oc/kubectl' '/usr/local/bin/' \
    && rm '/tmp/oc/openshift-client-linux.tar.gz' \
    "

# Red Hat OpenShift on AWS CLI
RUN bash -c "mkdir -p '/tmp/rosa' \
    && wget -nv -O '/tmp/rosa/rosa-linux.tar.gz' 'https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/rosa/latest/rosa-linux.tar.gz' \
    && tar zxvf '/tmp/rosa/rosa-linux.tar.gz' -C '/tmp/rosa' \
    && sudo mv  '/tmp/rosa/rosa' '/usr/local/bin/' \
    && rm '/tmp/rosa/rosa-linux.tar.gz' \
    "

# odo
ARG ODO_URL="https://developers.redhat.com/content-gateway/rest/mirror/pub/openshift-v4/clients/odo/v3.10.0/odo-linux-amd64"
RUN bash -c "curl -L ${ODO_URL} -o odo \
    && curl -L ${ODO_URL}.sha256 -o odo.sha256 \
    && echo "$(<odo.sha256)  odo" | shasum -a 256 --check \
    && sudo install -o root -g root -m 0755 odo /usr/local/bin/odo \
    "

# OpenShift Local (crc) - no virt flags
# ARG CRC_URL="https://developers.redhat.com/content-gateway/rest/mirror/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz"
# RUN bash -c "mkdir -p '/tmp/crc' \
#     && wget -nv -O '/tmp/crc/crc-linux-amd64.tar.xz' '${CRC_URL}' \
#     && tar xvf '/tmp/crc/crc-linux-amd64.tar.xz' -C '/tmp/crc' \
#     && find '/tmp/crc' \
#     && sudo mv /tmp/crc/crc-linux-*/crc '/usr/local/bin/' \
#     && rm '/tmp/crc/crc-linux-amd64.tar.xz' \
#     "


# krew
# RUN bash -c "set -x; cd $(mktemp -d) \
#      && OS=$(uname | tr '[:upper:]' '[:lower:]') \
#      && ARCH=$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/') \
#      && KREW=krew-${OS}_${ARCH} \
#      && curl -fsSLO https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz \
#      && tar zxvf ${KREW}.tar.gz \
#      && ./${KREW} install krew \
#      && mkdir -p  /home/gitpod/bashrc.d/
#      && echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> /home/gitpod/bashrc.d/krew.sh \
#      && chmod +x /home/gitpod/bashrc.d/krew.sh
#      "

# Operator SDK
RUN bash -c "brew install operator-sdk"

# Helm, Terraform, Terragrunt
RUN bash -c "brew install helm terraform terragrunt"

# KAN https://github.com/redhat-developer/kam

# Tackle
# RUN bash -c 'git clone "https://github.com/kubernetes/test-infra" "/tmp/test-infra" \
#    && cd /tmp/test-infra/prow/cmd/tackle \
#    && go build -o tackle \
#    && sudo mv tackle /usr/sbin/tackle \
#    '

# ArgoCD and Tekton
RUN bash -c "brew install argocd"
RUN bash -c "sudo apt install -y tektoncd-cli \
    && tkn version"

# Kustomize
RUN bash -c "curl -s 'https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh'  | bash"



# AWS CLIs
RUN bash -c "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip' && unzip awscliv2.zip \
    && sudo ./aws/install \
    && aws --version \
    "

RUN bash -c "npm install -g aws-cdk"

ARG SAM_URL="https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"
RUN bash -c "curl -Ls '${SAM_URL}' -o '/tmp/aws-sam-cli-linux-x86_64.zip' \
    && unzip '/tmp/aws-sam-cli-linux-x86_64.zip' -d '/tmp/sam-installation' \
    && sudo '/tmp/sam-installation/install' \
    && sam --version"

RUN bash -c "pip install cloudformation-cli cloudformation-cli-java-plugin cloudformation-cli-go-plugin cloudformation-cli-python-plugin cloudformation-cli-typescript-plugin"

# Azure CLI
RUN bash -c "curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash"

# Aliyun CLI
RUN bash -c "brew install aliyun-cli"

# Google CLI
RUN bash -c "curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-437.0.1-linux-x86_64.tar.gz \
    && tar -xf google-cloud-cli-437.0.1-linux-x86_64.tar.gz \
    && rm google-cloud-cli-437.0.1-linux-x86_64.tar.gz \
    && ./google-cloud-sdk/install.sh --quiet \
    && sudo ln -s /workspace/red-pod/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud \
    "


# Done :)
RUN bash -c "echo 'done.'"

