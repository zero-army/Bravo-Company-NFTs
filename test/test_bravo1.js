const testBravo1 = artifacts.require("OnchainBravoNFTs");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */


contract("OnchainBravoNFTs", function (/* accounts */) {
  it("should assert true", async function () {
    await testBravo1.deployed();
    return assert.isTrue(true);
  });

  it("should return the total supply of NFTs", async function () {
    let instance = await testBravo1.deployed();
    let totalSupply = await instance.totalSupply(0);
    assert.equal(totalSupply, 990000000000000000000000);
  });


  
});
  
