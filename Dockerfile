# Latest LTS Jenkins image — Debian + JDK17
FROM jenkins/jenkins:lts-jdk17

USER root

# Install required packages
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository (official 2026 instructions)
RUN echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/etc/apt/keyrings/docker.asc] \
    https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" \
    > /etc/apt/sources.list.d/docker.list

# Install latest Docker CLI 
RUN apt-get update && apt-get install -y \
    docker-ce-cli
    
    
#add user to the group
RUN groupadd -f docker && usermod -aG docker jenkins

# Switch back to Jenkins user
USER jenkins

# Install plugins 
RUN jenkins-plugin-cli --plugins "docker-workflow pipeline-graph-view"