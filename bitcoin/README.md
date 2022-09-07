# Docker Build

Inspired in https://github.com/ruimarinho/docker-bitcoin-core/blob/master/22/Dockerfile

## build
```
$ docker buildx build --force-rm --tag bitcoin-core .
$ docker build --force-rm --build-arg TARGETPLATFORM=linux/amd64 --tag bitcoin-core .
```

## run
```
$ docker run --rm --name bitcoin bitcoin-core
```

```
$ docker run --rm -it \
    -p 18443:18443 \
    -p 18444:18444 \
    --name bitcoin \
    bitcoin-core \
    --printtoconsole \
    -regtest=1 \
    -rpcallowip=172.17.0.0/16 \
    -rpcbind=0.0.0.0 \
    -rpcauth='foo:7d9ba5ae63c3d4dc30583ff4fe65a67e$9e3634e81c11659e3de036d0bf88f89cd169c1039e6e09607562d54765c649cc'
```

## test
```
$ curl --data-binary '{"jsonrpc":"1.0","id":"1","method":"getnetworkinfo","params":[]}' http://foo:qDDZdeQ5vw9XXFeVnXT4PZ--tGN2xNjjR4nrtyszZx0=@127.0.0.1:18443/

{"result":{"version":220000,"subversion":"/Satoshi:22.0.0/","protocolversion":70016,"localservices":"0000000000000409","localservicesnames":["NETWORK","WITNESS","NETWORK_LIMITED"],"localrelay":true,"timeoffset":0,"networkactive":true,"connections":0,"connections_in":0,"connections_out":0,"networks":[{"name":"ipv4","limited":false,"reachable":true,"proxy":"","proxy_randomize_credentials":false},{"name":"ipv6","limited":false,"reachable":true,"proxy":"","proxy_randomize_credentials":false},{"name":"onion","limited":true,"reachable":false,"proxy":"","proxy_randomize_credentials":false},{"name":"i2p","limited":true,"reachable":false,"proxy":"","proxy_randomize_credentials":false}],"relayfee":0.00001000,"incrementalfee":0.00001000,"localaddresses":[],"warnings":""},"error":null,"id":"1"}
```

## push
```
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/q1a1a5c6
docker tag bitcoin-core:latest public.ecr.aws/q1a1a5c6/bitcoin-core:latest
docker push public.ecr.aws/q1a1a5c6/bitcoin-core:latest
```

# Security Scan

## anchore

### install
```
pip3 install anchorecli
docker-compose up -d
export ANCHORE_CLI_URL=http://localhost:8228/v1
export ANCHORE_CLI_USER=admin
export ANCHORE_CLI_PASS=foobar
curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sudo sh -s -- -b /usr/local/bin
```

### test
```
anchore-cli system status
anchore-cli image add docker.io/library/debian:latest
anchore-cli image wait docker.io/library/debian:latest
anchore-cli image list
anchore-cli evaluate check docker.io/library/debian:latest
```

### evaluate
```
anchore-cli image add public.ecr.aws/q1a1a5c6/bitcoin-core:latest
anchore-cli image wait public.ecr.aws/q1a1a5c6/bitcoin-core:latest
anchore-cli image list
anchore-cli evaluate check public.ecr.aws/q1a1a5c6/bitcoin-core:latest
```

```
$ anchore-cli image list
Full Tag                                           Image Digest                                                                   Analysis Status
docker.io/library/debian:latest                    sha256:c0508353648d7db3c313661409ca41a2d12c63a4d06007387679161a8372329f        analyzed
public.ecr.aws/q1a1a5c6/bitcoin-core:latest        sha256:c7124edd26368ceebeab9e0d708e3223a661b23323e1944c0ebbcabed5022624        analyzed

$ anchore-cli evaluate check public.ecr.aws/q1a1a5c6/bitcoin-core:latest
Image Digest: sha256:c7124edd26368ceebeab9e0d708e3223a661b23323e1944c0ebbcabed5022624
Full Tag: public.ecr.aws/q1a1a5c6/bitcoin-core:latest
Status: pass
Last Eval: 2022-09-18T12:58:33Z
Policy ID: 2c53a13c-1765-11e8-82ef-23527761d060
```

## grype

### install

#### linux
```
curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin
```

#### mac
```
brew tap anchore/grype
brew install grype
```

### test
```
if grype bitcoin-core:latest > /dev/null ; then echo passed ; else echo failed ; fi
```

# Calculate Logged IP frequency

## create sample file
```
./create-file.sh

```

## bash
```
./create-file.sh ips.txt 5
./create-file.sh ips.txt 500
```

## python
```
```
