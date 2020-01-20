const Virus = artifacts.require("./contracts/Virus.sol");
var ContractRegistry = artifacts.require("./contracts/ContractRegistry.sol");
var web3 = require('web3')
var tronweb = require('tronweb')
module.exports = async function(deployer, network, address) {
  //const [admin] = web3.eth.getAccounts();

  await deployer.deploy.apply(deployer, [ContractRegistry])
  const contractRegistry = await ContractRegistry.deployed()
  console.log(`Contract Registry Contract address: ${contractRegistry.address}`)

  
  console.log(address)
  const virusContract = await deployer.deploy(Virus);
  console.log(`Virus Contract Contract address: ${virusContract.address}`)



};
