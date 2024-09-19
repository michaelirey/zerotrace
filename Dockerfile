# docker build -t zero-trace .


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
