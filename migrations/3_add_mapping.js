
const fs = require('fs');
var MFBToken = artifacts.require("./MFBToken.sol");
var Gold = artifacts.require("./GoldToken.sol");
var MFBPool = artifacts.require("./MFBPool.sol");
var MFEToken = artifacts.require("./MFEToken.sol");
var NFTMarket = artifacts.require("./NFTMarket.sol");
var BlindBox = artifacts.require("./BlindBox.sol");
var Rebate = artifacts.require("./RebatePool.sol");
var AdrCenter = artifacts.require("./AddressCenter.sol");
var Pancake = artifacts.require("./Pancake.sol");


module.exports = async function(deployer) {
  const network = config.network;
  console.log(network);
  const instance = await AdrCenter.deployed()
  await instance.addContractMapping("rewardPool",MFBPool.address);
  await instance.addContractMapping("mfbToken",MFBToken.address);
  await instance.addContractMapping("blindbox",BlindBox.address);
  await instance.addContractMapping("mfeToken",MFEToken.address);
  await instance.addContractMapping("market",NFTMarket.address);
  await instance.addContractMapping("gold",Gold.address);
  await instance.addContractMapping("rebatePool",Rebate.address);
  await instance.addContractMapping("wallet","0xe798505BF9158Ba14D687877F96e99890e7580D3");
  await instance.addContractMapping("burn","0xe798505BF9158Ba14D687877F96e99890e7580D3");
  await instance.addContractMapping("lpPool","0xe798505BF9158Ba14D687877F96e99890e7580D3");
  await instance.addOperator("0xe798505BF9158Ba14D687877F96e99890e7580D3");
  if(network == 'ganache_gui' || network == 'ganache_docker'){
    await instance.addContractMapping("pancake",Pancake.address);
    await instance.addAddressSetting(true,8,1,1,2,4,Pancake.address);
  }
  //const isntance2 = await MFBToken.deployed();
  //await isntance2.transfer("0xe798505BF9158Ba14D687877F96e99890e7580D3","200000000000000000000000000");
};
