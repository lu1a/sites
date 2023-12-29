FROM lukemathwalker/cargo-chef:latest AS chef
WORKDIR app

FROM chef AS planner
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

FROM chef AS builder 
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
COPY . .
RUN cargo build --release --bin portfolio-site

FROM debian:bookworm-slim AS runtime
WORKDIR app
COPY ./static ./static
COPY --from=builder /app/target/release/portfolio-site /usr/local/bin
EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/portfolio-site"]
