# vaccine-tracker-smart-contracts

## Description

At a high level you need these prerequisites to run the contracts

+ A blockchain environment
+ A smart contract development suite
+ npm

## Quickstarts

Provided are two startup methods. The project was developed against the tron blockchain but should be usable in either.

### Tron
You need tronbox installed in order to compile and deploy the contracts to the tron network

```
npm i -g tronbox
```

A provided script is available to setup a local tron blockchain with Docker
```
yarn docker
```
Start a tronbox console session connecting to the local env
```
tronbox console --network development
```
>The below commands assume you are in a tronbox console session. Prefix with tronbox otherwise

To run tests
```
test
```
To deploy 

```
migrate
```

### Ethereum 

You need truffle installed in order to compile and deploy the contracts to the Ethereum network

```
npm i -g truffle
```

ganache-cli can be used to setup a local Ethereum blockchain
```
ganache-cli
```
Start a truffle console session connecting to the local env
```
truffle console --network development
```
>The below commands assume you are in a truffle console session. Prefix with truffle otherwise

To run tests
```
test
```
To deploy 

```
migrate
```