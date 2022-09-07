FROM debian:bullseye-slim

ARG TARGETPLATFORM
ENV BITCOIN_VERSION=22.0

RUN groupadd -r bitcoin \
 && useradd -m -g bitcoin bitcoin \
 && apt-get update -y \
 && apt-get install -y curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -ex \
 && if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then export TARGETPLATFORM=x86_64-linux-gnu; fi \
 && if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then export TARGETPLATFORM=aarch64-linux-gnu; fi \
 && if [ "${TARGETPLATFORM}" = "linux/arm64/v8" ]; then export TARGETPLATFORM=aarch64-linux-gnu; fi \
 && if [ "${TARGETPLATFORM}" = "linux/arm" ]; then export TARGETPLATFORM=arm-linux-gnueabihf; fi \
 && curl -SLO https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-${TARGETPLATFORM}.tar.gz \
 && curl -SLO https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS \
 && grep " bitcoin-${BITCOIN_VERSION}-${TARGETPLATFORM}.tar.gz" SHA256SUMS \
 && tar -xzf bitcoin-${BITCOIN_VERSION}-${TARGETPLATFORM}.tar.gz -C /opt \
 && rm bitcoin-${BITCOIN_VERSION}-${TARGETPLATFORM}.tar.gz SHA256SUMS \
 && chown -R bitcoin:bitcoin /opt/bitcoin-${BITCOIN_VERSION}

USER bitcoin

WORKDIR "/opt/bitcoin-${BITCOIN_VERSION}"

EXPOSE 8332 8333 18444 18443

ENTRYPOINT [ "bin/bitcoind" ]
CMD ["-daemonwait", "-printtoconsole"]
