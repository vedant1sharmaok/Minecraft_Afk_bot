FROM eclipse-temurin:21-jre

WORKDIR /app

# System deps for headless MC + Python
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    xvfb \
    libxrender1 \
    libxtst6 \
    libxi6 \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Python deps
RUN pip3 install --no-cache-dir fastapi uvicorn

COPY . .

RUN chmod +x start.sh

EXPOSE 8000

CMD ["./start.sh"]
