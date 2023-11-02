# docker build --no-cache --progress=plain -f Dockerfile .
FROM fedora

# System
RUN bash -c "sudo dnf -y update"
RUN bash -c "sudo dnf install -y zip unzip wget" 

# User Mode
RUN bash -c "groupadd -r container_group \
    && useradd -m -r -G container_group -u 1001 container_user"

USER container_user
WORKDIR "/home/container_user"

# Java
ARG JAVA_SDK="21-graal"
ENV SDKMAN_DIR "/home/container_user/.sdkman"

RUN bash -c "curl -s 'https://get.sdkman.io' | bash"
RUN bash -c "chmod a+x $SDKMAN_DIR/bin/sdkman-init.sh \
    && echo 'sdkman_auto_answer=true' > $SDKMAN_DIR/etc/config \
    && echo 'sdkman_auto_selfupdate=false' >> $SDKMAN_DIR/etc/config \
    && echo 'sdkman_insecure_ssl=false' >> $SDKMAN_DIR/etc/config \
    && . $SDKMAN_DIR/bin/sdkman-init.sh \
    && sdk install java $JAVA_SDK \
    && sdk default java $JAVA_SDK \
    && sdk install quarkus \
    && sdk install maven \
    "

# Done :)
# RUN bash -c "echo 'done.'"

