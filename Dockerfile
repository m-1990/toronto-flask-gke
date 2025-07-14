FROM ubuntu:latest

# Set non-interactive frontend for apt to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip \
    python3-venv

# Install FastAPI and Uvicorn
RUN python3 -m venv /venv \
    && /venv/bin/pip install --upgrade pip \
    && /venv/bin/pip install "fastapi[standard]" uvicorn flask

ENV PATH="/venv/bin:$PATH"

WORKDIR /app
# Copy your FastAPI app into the container
COPY app.py /app/
COPY templates/ /app/templates/
COPY static/ /app/static/

# Expose the port FastAPI runs on
EXPOSE 5000

# ENV FLASK_APP=app.py

# Run Flask
CMD ["flask", "run", "--host", "0.0.0.0"]


