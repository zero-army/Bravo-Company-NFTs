const BravoLibrary = artifacts.require("BravoLibrary");
const OnchainBravoNFTs = artifacts.require("OnchainBravoNFTs");

module.exports = async function (deployer) {
  // Deploy BravoLibrary first
  await deployer.deploy(BravoLibrary);
  await BravoLibrary.detectNetwork();


  // const bravoLibrary = await BravoLibrary.new();
  console.log("[X] - BravoLibrary deployed to:", BravoLibrary.address);
  
  // Link BravoLibrary to OnchainBravoNFTs contract
  const network = await OnchainBravoNFTs.detectNetwork();
  console.log("[X] - network:", network);
  await deployer.link(BravoLibrary, OnchainBravoNFTs);
  
  // Deploy OnchainBravoNFTs contract
  await deployer.deploy(OnchainBravoNFTs);
  console.log("[X] - OnchainBravoNFTs deployed to:", OnchainBravoNFTs.address);

  // const bravoNFTs = await OnchainBravoNFTs.new();
  // console.log("OnchainBravoNFTs deployed to:", bravoNFTs.address);
  // console.log("OnchainBravoNFTs last deployed to:", OnchainBravoNFTs.address);

  // await BravoLibrary.detectNetwork();
  // const bravoLibrary = await BravoLibrary.new();
  // const network = await OnchainBravoNFTs.detectNetwork();
  // console.log("network:", network);

  // console.log("BravoLibrary deployed to:", bravoLibrary.address);
  // // Link BravoLibrary to OnchainBravoNFTs contract
  // await OnchainBravoNFTs.link("BravoLibrary", bravoLibrary.address);
  // // Deploy OnchainBravoNFTs contract
  // const onchainBravoNFTs = await OnchainBravoNFTs.new();
  // console.log("OnchainBravoNFTs deployed to:", onchainBravoNFTs.address);

};
