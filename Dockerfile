FROM eclipse-temurin:21

WORKDIR /app

RUN apt-get update && \
    apt-get install -y python3 python3-pip xvfb && \
    pip install fastapi uvicorn

COPY . .

CMD ["bash", "run.sh"]
