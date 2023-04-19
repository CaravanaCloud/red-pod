# docker build --no-cache --progress=plain -f .gitpod.Dockerfile .
FROM gitpod/workspace-full

# System
RUN bash -c "sudo install-packages direnv gettext"

# Java
ARG JAVA_SDK="20-amzn"
RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh && sdk install java $JAVA_SDK && sdk default java $JAVA_SDK && sdk install quarkus"

# AWS
RUN bash -c "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip' && unzip awscliv2.zip && sudo ./aws/install"
RUN bash -c "npm install -g aws-cdk"
RUN bash -c "curl -Ls 'https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip' -o '/tmp/aws-sam-cli-linux-x86_64.zip' && unzip '/tmp/aws-sam-cli-linux-x86_64.zip' -d '/tmp/sam-installation' && sudo '/tmp/sam-installation/install' && sam --version"
RUN bash -c "pip install cloudformation-cli cloudformation-cli-java-plugin cloudformation-cli-go-plugin cloudformation-cli-python-plugin cloudformation-cli-typescript-plugin"

# Aliyun
RUN bash -c "curl 'https://aliyuncli.alicdn.com/aliyun-cli-linux-3.0.2-amd64.tgz?spm=a2c63.p38356.0.0.51f94891CK6zc9&file=aliyun-cli-linux-3.0.2-amd64.tgz' -o 'aliyun-cli-linux-3.0.2-amd64.tgz' && tar zxvf aliyun-cli-linux-3.0.2-amd64.tgz && sudo mv aliyun /usr/local/bin/aliyun && rm aliyun-cli-linux-3.0.2-amd64.tgz"

# Azure
RUN bash -c "curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash"

# Red Hat
RUN bash -c "mkdir -p '/tmp/openshift-installer' && wget -nv -O '/tmp/openshift-installer/openshift-install-linux.tar.gz' 'https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/openshift-install-linux.tar.gz' && tar zxvf '/tmp/openshift-installer/openshift-install-linux.tar.gz' -C '/tmp/openshift-installer' && sudo mv  '/tmp/openshift-installer/openshift-install' '/usr/local/bin/' && rm '/tmp/openshift-installer/openshift-install-linux.tar.gz'"
RUN bash -c "mkdir -p '/tmp/rosa' && wget -nv -O '/tmp/rosa/rosa-linux.tar.gz' 'https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/rosa/latest/rosa-linux.tar.gz' && tar zxvf '/tmp/rosa/rosa-linux.tar.gz' -C '/tmp/rosa' && sudo mv  '/tmp/rosa/rosa' '/usr/local/bin/' && rm '/tmp/rosa/rosa-linux.tar.gz'"
RUN bash -c "mkdir -p '/tmp/oc' && wget -nv -O '/tmp/oc/openshift-client-linux.tar.gz' 'https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/openshift-client-linux.tar.gz' && tar zxvf '/tmp/oc/openshift-client-linux.tar.gz' -C '/tmp/oc' && sudo mv '/tmp/oc/oc' '/usr/local/bin/' && sudo mv '/tmp/oc/kubectl' '/usr/local/bin/' && rm '/tmp/oc/openshift-client-linux.tar.gz'"
RUN bash -c "mkdir -p '/tmp/ccoctl' && wget -nv -O '/tmp/ccoctl/ccoctl-linux.tar.gz' 'https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/ccoctl-linux.tar.gz' && tar zxvf '/tmp/ccoctl/ccoctl-linux.tar.gz' -C '/tmp/oc' && sudo mv '/tmp/ccoctl/ccoctl' '/usr/local/bin/' && rm '/tmp/ccoctl/ccoctl-linux.tar.gz'"


# RUN bash -c "mkdir -p '/tmp/flyway' && wget -nv -O '/tmp/flyway/flyway-commandline-8.5.11-linux-x64.tar.gz' 'https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/8.5.11/flyway-commandline-8.5.11-linux-x64.tar.gz' && tar zxvf '/tmp/flyway/flyway-commandline-8.5.11-linux-x64.tar.gz' -C '/tmp/flyway/' && sudo mv '/tmp/flyway/flyway-8.5.11' '/usr/local/flyway' && sudo ln -s '/usr/local/flyway/flyway' '/usr/local/bin/flyway' && rm -rf '/tmp/flyway'"
# RUN bash -c "sudo install-packages mysql-client"
