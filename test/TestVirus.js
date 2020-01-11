var Virus = artifacts.require("./Virus.sol");
const { testWillThrow } =  require('./utils/helpers')

contract('Virus', (accounts) => {
  const admin = accounts[0];
  const competitor = accounts[1];

  var validIpfsHash = "QmPXgPCzbdviCVJTJxvYCWtMuRWCKRfNRVcSpARHDKFSha"
  let virusContract

  beforeEach(async () => {
    //tronbox cannot use .new(). One way to use new is through tronweb instead.
    virusContract = await Virus.deployed();
  })

  it("A vaccine can be added to a virus", async () => {
    // Result is a string 
    //This represents one way to do contract function calls and is an example of promise chaining
    // const test = await Virus.deployed().then(function(instance){return instance.addVaccine(admin,"BCG",validIpfsHash);});
    // console.log(test)
    const tx_hash = await virusContract.addVaccine(admin,"BCG",validIpfsHash);
    console.log(tx_hash);

    const response = await virusContract.call('addVaccine', admin,"BCG",validIpfsHash);
    console.log(`[DEBUG] <Test #1> response: ${response}`);
    assert.ok(response);

    // const tx_hash2 = await virusContract.addVaccine(competitor,"BCG",validIpfsHash);
    // console.log(tx_hash);
  });

  it("A pleb cannot add vaccine to a virus", async () => {
    // Result is a string 
    //This represents one way to do contract function calls and is an example of promise chaining

    
    await testWillThrow(
      virusContract.addVaccine,
      [competitor, "BCG",validIpfsHash],
      { from: competitor },
      'Error: invalid address'
    )
  });
  
}); 
