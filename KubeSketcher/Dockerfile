FROM golang:1.17 as builder

WORKDIR /app

RUN git clone https://github.com/mkimuram/k8sviz.git \
    && cd k8sviz \
    && make build

COPY go.* ./
RUN go mod download

COPY . ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -o ./find-namespaces ./src/main.go

FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    wget \
    python3 \
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/ \
    && wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && \
    unzip google-cloud-sdk.zip && \
    google-cloud-sdk/install.sh -q && \
    rm google-cloud-sdk.zip

ENV PATH=$PATH:/app/bin
ENV PATH $PATH:/google-cloud-sdk/bin

COPY --from=builder /app/k8sviz/bin/k8sviz /app/bin/
COPY --from=builder /app/k8sviz/icons /app/bin/icons
COPY --from=builder /app/find-namespaces /app/bin/
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh


ENTRYPOINT ["/app/entrypoint.sh"]
