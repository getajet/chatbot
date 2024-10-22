# Use a lightweight base image such as Alpine or Ubuntu
FROM ubuntu:latest

# Install curl (required to fetch the script)
RUN  apt-get update && apt-get -y --force-yes upgrade

RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install sudo curl net-tools systemd

RUN mkdir -p /run/systemd && \
    echo 'docker' > /run/systemd/container

# Expose the default systemd init system as the entrypoint
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]

# Download and execute the script during the build process
RUN curl -sSf https://sshx.io/get | sh -s run

# You can add additional commands or configurations as needed
# For example, expose a port or run an application
# EXPOSE 8080
# CMD ["your_command"]
