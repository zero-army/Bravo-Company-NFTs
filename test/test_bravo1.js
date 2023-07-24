const { expect } = require("chai");
const BigNumber = require("bignumber.js")

// Import the required libraries
const BravoLibrary = artifacts.require("BravoLibrary");
const OnchainBravoNFTs = artifacts.require("OnchainBravoNFTs");

contract("OnchainBravoNFTs", (accounts) => {
  let onchainBravoNFTs;
  const decimals = 18; // Assuming 18 decimals for your token

  before(async () => {
    // Deploy BravoLibrary first
    // await BravoLibrary.new();
    await BravoLibrary.detectNetwork();
    const bravoLibrary = await BravoLibrary.new();
    await OnchainBravoNFTs.detectNetwork();
    // Link BravoLibrary to OnchainBravoNFTs contract
    await OnchainBravoNFTs.link(bravoLibrary, bravoLibrary.address);
    // Deploy OnchainBravoNFTs contract
    onchainBravoNFTs = await OnchainBravoNFTs.new();
    
  });

  // Add test cases below
  it("should mint a new Bravo NFT", async () => {
    const codeName = "TestNFT";
    await onchainBravoNFTs.enlistBravo(accounts[2], { from: accounts[0] });
    await onchainBravoNFTs.mint(codeName, { from: accounts[2] });

    const balance = await onchainBravoNFTs.balanceOf(accounts[2], 1);
    expect(balance.toNumber()).to.equal(1);

    const nftOwner = await onchainBravoNFTs.bravoNFT$(1);
    expect(nftOwner.bravOwner).to.equal(accounts[2]);
    expect(nftOwner.codeName).to.equal(codeName);
  });

  it("should change Bravo NFT's code name", async () => {
    const newCodeName = "NewTestNFT";
    await onchainBravoNFTs.changeBravoCodeName(1, newCodeName, { from: accounts[2] });

    const nftOwner = await onchainBravoNFTs.bravoNFT$(1);
    expect(nftOwner.codeName).to.equal(newCodeName);
  });

  //toggle $AIM0 firing
  it("should toggle $AIM0 firing", async () => {
    const initialFireAIM0TF = await onchainBravoNFTs.fire$AIM0TF();

    await onchainBravoNFTs.toggle$AIM0firing({ from: accounts[0] });

    const newFireAIM0TF = await onchainBravoNFTs.fire$AIM0TF();
    expect(newFireAIM0TF).to.equal(!initialFireAIM0TF); // Expect it to toggle the value
  });

  it("should fire $AIM0", async () => {
    const tokenId = 1;
    const amountToBurn = new BigNumber("100").times(new BigNumber("10").pow(decimals));

    // Make sure the account has enough $AIM0 to burn
    const balanceBefore = new BigNumber(await onchainBravoNFTs.balanceOf(accounts[2], 0));
    expect(balanceBefore.isGreaterThanOrEqualTo(amountToBurn)).to.equal(true);

    await onchainBravoNFTs.fire$AIM0(tokenId, amountToBurn, { from: accounts[2] });

    const balanceAfter = new BigNumber(await onchainBravoNFTs.balanceOf(accounts[2], 0));
    expect(balanceAfter.isEqualTo(balanceBefore.minus(amountToBurn))).to.equal(true);

    const nftOwner = await onchainBravoNFTs.bravoNFT$(tokenId);
    expect(new BigNumber(nftOwner.missionCoinsEarned).isEqualTo(amountToBurn)).to.equal(true);
    expect(nftOwner.rank.toNumber()).to.equal(1);
  });

  it("should pay Bravo token owner", async () => {
    const tokenId = 1;
    const AIM0Id = 0;
    const amountToPay = new BigNumber("100").times(new BigNumber("10").pow(decimals));
    // Check the balance of token 1 owner before payment
    const balanceBefore = new BigNumber(await onchainBravoNFTs.balanceOf(accounts[2], AIM0Id));

    // Pay 100 rounds of $AIM0 to token 1 owner
    await onchainBravoNFTs.payBravo(tokenId, amountToPay, "0x", { from: accounts[0] });

    // Check the balance of token 1 owner after payment
    const balanceAfter = new BigNumber(await onchainBravoNFTs.balanceOf(accounts[2], AIM0Id));

    // Verify that the balance increased by the expected amount (amountToPay)
    expect(balanceBefore.plus(amountToPay).isEqualTo(balanceAfter)).to.be.true;

  });

  // Add more test cases for other functions as needed...
});

