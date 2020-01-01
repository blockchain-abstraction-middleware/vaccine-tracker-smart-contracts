const Virus = artifacts.require("../contracts/Virus.sol");

module.exports = function(deployer) {
  deployer.deploy(Virus);
};
