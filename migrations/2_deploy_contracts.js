var MFBToken = artifacts.require("./MFBToken.sol");
var Gold = artifacts.require("./GoldToken.sol");
var MFBPool = artifacts.require("./MFBPool.sol");
var MFEToken = artifacts.require("./MFEToken.sol");
var NFTMarket = artifacts.require("./NFTMarket.sol");
var BlindBox = artifacts.require("./BlindBox.sol");
var Rebate = artifacts.require("./RebatePool.sol");
var AdrCenter = artifacts.require("./AddressCenter.sol");
var Pancake = artifacts.require("./Pancake.sol");
//var Busd = artifacts.require("./BUSD.sol");


module.exports = async function(deployer) {
  const network = config.network;
  console.log(network);
  await deployer.deploy(AdrCenter);
  await deployer.deploy(MFBPool, AdrCenter.address);
  await deployer.deploy(MFBToken, AdrCenter.address);
  await deployer.deploy(Gold, AdrCenter.address);
  await deployer.deploy(MFEToken, AdrCenter.address);
  await deployer.deploy(NFTMarket, AdrCenter.address);
  await deployer.deploy(BlindBox, AdrCenter.address);
  await deployer.deploy(Rebate, AdrCenter.address);
  //await deployer.deploy(Busd);
  if(network == 'ganache_gui' || network == 'ganache_docker'){
    await deployer.deploy(Pancake);
  }
  var fs = require('fs');
  const mfb = JSON.parse(fs.readFileSync('./build/contracts/MFBToken.json', 'utf8'));
  const mfbPool = JSON.parse(fs.readFileSync('./build/contracts/MFBPool.json', 'utf8'));
  const market = JSON.parse(fs.readFileSync('./build/contracts/NFTMarket.json', 'utf8'));
  const nft = JSON.parse(fs.readFileSync('./build/contracts/MFEToken.json', 'utf8'));
  const rebatePool = JSON.parse(fs.readFileSync('./build/contracts/RebatePool.json', 'utf8'));
  const gold = JSON.parse(fs.readFileSync('./build/contracts/GoldToken.json', 'utf8'));
  const adrCenter = JSON.parse(fs.readFileSync('./build/contracts/AddressCenter.json', 'utf8'));
  const box = JSON.parse(fs.readFileSync('./build/contracts/BlindBox.json', 'utf8'));
  const pancake = JSON.parse(fs.readFileSync('./build/contracts/Pancake.json', 'utf8'));
  //const busd = JSON.parse(fs.readFileSync('./build/contracts/BUSD.json', 'utf8'));
  var obj = [];
  obj.push({contract_id: "3", name: "BLIND_BOX", contract_name: "盲盒合約",contract_address: BlindBox.address, abi:JSON.stringify(box.abi)});
  obj.push({contract_id: "4", name: "MFB_NFT_TRADE", contract_name: "NFT交易合約",contract_address: NFTMarket.address, abi:JSON.stringify(market.abi)});
  obj.push({contract_id: "5", name: "MFB_NFT", contract_name: "NFT合約",contract_address: MFEToken.address, abi:JSON.stringify(nft.abi)});
  obj.push({contract_id: "6", name: "AGENT_SHARE", contract_name: "反傭池合約",contract_address: Rebate.address, abi:JSON.stringify(rebatePool.abi)});
  obj.push({contract_id: "7", name: "MFB_TOKEN", contract_name: "MFB代幣合約",contract_address: MFBToken.address, abi:JSON.stringify(mfb.abi)});
  obj.push({contract_id: "8", name: "GOLD_TOKEN", contract_name: "Gold Token合約",contract_address: Gold.address, abi:JSON.stringify(gold.abi)});
  obj.push({contract_id: "9", name: "REWARD_SHARE", contract_name: "獎勵池合約",contract_address: MFBPool.address, abi:JSON.stringify(mfbPool.abi)});
  obj.push({contract_id: "10", name: "ADR_CENTER", contract_name: "地址設定合約",contract_address: AdrCenter.address, abi:JSON.stringify(adrCenter.abi)});
  if(network == 'testnet'){
    //obj.push({contract_id: "11", name: "BUSD", contract_name: "BUSD合約",contract_address: Busd.address, abi:JSON.stringify(busd.abi)});
  }
  if(network == 'ganache_gui' || network == 'ganache_docker'){
    obj.push({contract_id: "11", name: "PANCAKE", contract_name: "Pancake合約",contract_address: Pancake.address, abi:JSON.stringify(pancake.abi)});
  }
  var json = JSON.stringify(obj)
  var name = 'address_' + network + ".json"
  fs.writeFile(name, json, 'utf8', function (err) {
    if (err) {
     console.log("An error occurred while writing JSON Object to File.");
     return console.log(err);
    }
    console.log("JSON file has been saved.");
  });
  
};
