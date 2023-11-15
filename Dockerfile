FROM golang:1.21-alpine

WORKDIR /app
COPY . .

RUN go build -o portfolio-site main.go
RUN chmod +x portfolio-site

EXPOSE 3000

CMD ./portfolio-site
