FROM debian:latest AS build

RUN apt update
RUN apt upgrade -y

RUN apt install cargo -y
RUN apt install pkg-config -y

RUN mkdir /src
WORKDIR  /src
COPY . .

RUN cargo build --release

FROM debian:latest AS base
COPY --from=build /src/target/release/cherry-server /bin
RUN chmod +x /bin/cherry-server
ENTRYPOINT /bin/cherry-server
