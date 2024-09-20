# docker build -t zero-trace .

# Buiild and push the Docker image
# docker buildx build --platform linux/amd64,linux/arm64 -t michaelirey/zero-trace:latest -t michaelirey/zero-trace:0.1 --push .


# Use a lightweight base image
FROM debian:bullseye-slim

LABEL description="Docker container for multi-layer encryption with automatically generated passwords."

# Update and install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    openssl \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /workspace

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Default command
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Expose workspace volume
VOLUME /workspace
