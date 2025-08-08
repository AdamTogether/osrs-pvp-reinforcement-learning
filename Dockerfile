# Dockerfile for OSRS PvP Reinforcement Learning

# Use micromamba for lightweight conda environment management
FROM mambaorg/micromamba:1.5.1

# Create working directory
WORKDIR /app

# Copy environment definition and install dependencies
COPY pvp-ml/environment.yml /tmp/environment.yml
RUN micromamba install -y -n pvpml -f /tmp/environment.yml \
    && micromamba clean --all --yes

# Ensure environment binaries are on PATH
ENV PATH="/opt/conda/envs/pvpml/bin:$PATH"

# Copy repository code
COPY . /app

# Default to bash shell when starting container
CMD ["/bin/bash"]
