const testBravo1 = artifacts.require("testBravo1");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("testBravo1", function (/* accounts */) {
  it("should assert true", async function () {
    await testBravo1.deployed();
    return assert.isTrue(true);
  });
});
