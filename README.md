# volatility-bitlocker

Voliatility 2.5 docker image with bitlocker plugin

## Build

`docker build . -t r1cebank/volatility`

## Usage

`docker run --rm -v [memory dump dir]:/data:ro r1cebank/volatility --plugins=/plugins -f nu2.raw --profile Win8SP1x64 bitlocker`

*replace r1cebank/volatility with your image tag*
*replace Win8SP1x64 with the target OS profile*