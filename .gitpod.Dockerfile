FROM gitpod/workspace-full

RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh && sdk install java 22.1.0.r17-grl && sdk default java 22.1.0.r17-grl && sdk install quarkus"
RUN bash -c "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip' && unzip awscliv2.zip && sudo ./aws/install"
RUN bash -c "npm install -g aws-cdk"

# RUN bash -c "mkdir -p "$INSTALL_DIR" wget -nv -O "$INSTALL_FILE" "$INSTALL_URL" tar zxvf "$INSTALL_FILE" -C "$INSTALL_DIR" sudo mv  "$INSTALL_TARGET" "$INSTALL_PATH" rm "$INSTALL_FILE""
# INSTALL_URL: https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/openshift-install-linux.tar.gz
# INSTALL_DIR: /tmp/openshift-installer
# INSTALL_FILE: /tmp/openshift-installer/openshift-install-linux.tar.gz
# INSTALL_TARGET: /tmp/openshift-installer/openshift-install
# INSTALL_PATH: /usr/local/bin/
