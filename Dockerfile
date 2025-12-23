FROM dgraph/standalone:latest

COPY init.sh /init.sh
RUN chmod +x /init.sh

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
