# Dockerfile for OSRS PvP Reinforcement Learning

# Use micromamba for lightweight conda environment management
FROM mambaorg/micromamba:1.5.1

# Create working directory
WORKDIR /app

# Copy source needed for environment creation with write permissions
COPY --chown=1000:1000 pvp-ml /app/pvp-ml

# Create conda environment from specification
WORKDIR /app/pvp-ml
RUN micromamba create -y -f environment.yml \
    && micromamba clean --all --yes

# Ensure environment binaries are on PATH
ENV PATH="/opt/conda/envs/pvp/bin:$PATH"

# Copy repository code
WORKDIR /app
COPY . /app

# Default to bash shell when starting container
CMD ["/bin/bash"]
