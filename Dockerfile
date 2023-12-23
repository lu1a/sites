FROM rust:1.74.1-slim

WORKDIR /app
COPY . .

RUN cargo build --release
RUN chmod +x target/release/portfolio-site

EXPOSE 3000

CMD ./target/release/portfolio-site
