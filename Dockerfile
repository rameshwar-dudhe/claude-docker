FROM node:22-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
      git curl ca-certificates openssh-client ripgrep less procps \
    && rm -rf /var/lib/apt/lists/*

# Claude Code CLI
RUN npm install -g @anthropic-ai/claude-code

# Run as non-root user
RUN useradd -m -s /bin/bash claude
USER claude
ENV HOME=/home/claude
WORKDIR /workspace

CMD ["claude"]
