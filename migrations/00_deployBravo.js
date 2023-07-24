const BravoLibrary = artifacts.require("BravoLibrary");
const OnchainBravoNFTs = artifacts.require("OnchainBravoNFTs");

module.exports = async function (deployer) {
  // Deploy BravoLibrary first
  await deployer.deploy(BravoLibrary);
  await BravoLibrary.detectNetwork();
  // const bravoLibrary = await BravoLibrary.new();
  console.log("BravoLibrary deployed to:", BravoLibrary.address);
  
  // Link BravoLibrary to OnchainBravoNFTs contract
  await OnchainBravoNFTs.detectNetwork();
  await deployer.link(BravoLibrary, OnchainBravoNFTs);
  
  // Deploy OnchainBravoNFTs contract
  await deployer.deploy(OnchainBravoNFTs);
  console.log("OnchainBravoNFTs 1st deployed to:", OnchainBravoNFTs.address);
  // const bravoNFTs = await OnchainBravoNFTs.new();
  // console.log("OnchainBravoNFTs deployed to:", bravoNFTs.address);
  // console.log("OnchainBravoNFTs last deployed to:", OnchainBravoNFTs.address);
};
