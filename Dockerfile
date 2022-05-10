ARG VARIANT="6.0"
FROM mcr.microsoft.com/dotnet/sdk:${VARIANT} AS builder

# RUN useradd -m app
WORKDIR /home/app
COPY . .

# RUN chown -R app /home/app
# USER app
RUN dotnet restore
RUN dotnet publish \
    -p:PublishSingleFile=true \
    --self-contained \
    --configuration \
    Release -r linux-x64

FROM debian:bullseye-slim

RUN useradd -m app
WORKDIR /home/app

COPY --from=builder \
    /home/app/bin/Release/net6.0/linux-x64/publish \
    .

RUN chown -R app /home/app

RUN apt update && apt upgrade -y

RUN apt install -y libcap2-bin

# RUN chmod 755 /usr/local/bin/server

RUN setcap 'cap_net_bind_service=+ep' /home/app/workspace

# app用のsocket
# RUN mkdir /var/run/go && chown app /var/run/go

USER app
WORKDIR /home/app

CMD ["/home/app/workspace"]
