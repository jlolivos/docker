FROM ubuntu:18.04

LABEL maintainer="Jorge Olivos <jlolivos@gmail.com>"

# Make sure the package repository is up to date.
RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy git && \
    apt-get install -qy net-tools && \
# Install a basic SSH server
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
# Install JDK 8
    apt-get install -qy openjdk-8-jdk && \
# Install maven
    apt-get install -qy maven && \
# Cleanup old package
    apt-get autoremove -qy && \
# Add user jenkins to the image
    adduser --disabled-password --gecos "" jenkins && \
# Set password for the jenkins user
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.m2
#ADD settings.xml /home/jenkins/.m2/
#COPY resources/settings.xml /home/jenkins/.m2/
# Copy authorized keys
#COPY resources/authorized_keys /home/jenkins/.ssh/authorized_keys
# Change privileges over files copied
#RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
#    chown -R jenkins:jenkins /home/jenkins/.ssh/
# Standard SSH port
#EXPOSE 22

#CMD ["/usr/sbin/sshd", "-D"]
