# Container image that runs your code
FROM alpine:3.10

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Install yq 4.34.1
COPY --from=mikefarah/yq@sha256:1628fe407628354ff041878c26d934922d672a5a76637ea6898b0d4dd8c9d6cd /usr/bin/yq /usr/bin/yq

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

