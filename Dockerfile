FROM golang:1.22

RUN apt-get install -y

WORKDIR /hello-privilee

COPY ./ /hello-privilee

RUN go mod download && \
    go mod tidy && \
    go build

EXPOSE 1323

# Run
CMD ["go", "run", "hello-privilee"]