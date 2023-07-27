const BravoLibrary = artifacts.require("BravoLibrary");
const OnchainBravoNFTs = artifacts.require("OnchainBravoNFTs");

module.exports = async function (deployer) {
  // METHOD 1 *****************************************************
  // Deploy BravoLibrary first
  await deployer.deploy(BravoLibrary);
  await BravoLibrary.detectNetwork();

  // const bravoLibrary = await BravoLibrary.new();
  console.log("[X] - BravoLibrary deployed to:", BravoLibrary.address);
  
  // Link BravoLibrary to OnchainBravoNFTs contract
  const network = await OnchainBravoNFTs.detectNetwork();
  console.log("[X] - Network:", network);
  await deployer.link(BravoLibrary, OnchainBravoNFTs);
  
  // Deploy OnchainBravoNFTs contract
  await deployer.deploy(OnchainBravoNFTs);
  console.log("[X] - OnchainBravoNFTs deployed to:", OnchainBravoNFTs.address);

  
  // METHOD 1.5 *****************************************************
  // const bravoNFTs = await OnchainBravoNFTs.new();
  // console.log("OnchainBravoNFTs deployed to:", bravoNFTs.address);
  // console.log("OnchainBravoNFTs last deployed to:", OnchainBravoNFTs.address);
  // await BravoLibrary.detectNetwork();
  // const bravoLibrary = await BravoLibrary.new();
  // const network = await OnchainBravoNFTs.detectNetwork();
  // console.log("network:", network);
  // // Deploy OnchainBravoNFTs contract
  // const onchainBravoNFTs = await OnchainBravoNFTs.new();
  // console.log("OnchainBravoNFTs deployed to:", onchainBravoNFTs.address);


  // METHOD 2 *****************************************************
  // Deploy BravoLibrary first
  // await deployer.deploy(BravoLibrary);
  // await BravoLibrary.detectNetwork();
  // const bravoLibrary = await BravoLibrary.deployed();
  // console.log("[X] - BravoLibrary deployed to:", bravoLibrary.address);

  
  // // Link BravoLibrary to OnchainBravoNFTs contract
  // const bravoLibraryCopy = "0xB8E745f1BA4330D7a6AA88f50A6e767cECC9e61a";
  // await OnchainBravoNFTs.detectNetwork();
  // await OnchainBravoNFTs.link("BravoLibrary", bravoLibraryCopy.address);
  // await deployer.deploy(OnchainBravoNFTs);
  // const onChainBravoNFTs = await OnchainBravoNFTs.deployed();
  // // Deploy OnchainBravoNFTs contract
  // console.log("[X] - OnchainBravoNFTs deployed to:", onChainBravoNFTs.address);

};
