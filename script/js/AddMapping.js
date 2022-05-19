var MFBToken = artifacts.require("./MFBToken.sol");
var Gold = artifacts.require("./GoldToken.sol");
var MFBPool = artifacts.require("./MFBPool.sol");
var MFEToken = artifacts.require("./MFEToken.sol");
var NFTMarket = artifacts.require("./NFTMarket.sol");
var BlindBox = artifacts.require("./BlindBox.sol");
var Rebate = artifacts.require("./RebatePool.sol");
var AdrCenter = artifacts.require("./AddressCenter.sol");
var Pancake = artifacts.require("./Pancake.sol");


module.exports = async function(mapper) {
    let Web3 = require('web3');
    const truffleContract = require('truffle-contract')
    let contract = truffleContract(require('../build/contracts/AddressCenter.json'));
    var provider = new Web3.providers.HttpProvider("http://localhost:8545");
    var web3 = new Web3(provider);
    contract.setProvider(web3.currentProvider);

    //workaround: https://github.com/trufflesuite/truffle-contract/issues/57
    if (typeof contract.currentProvider.sendAsync !== "function") {
        contract.currentProvider.sendAsync = function() {
        return contract.currentProvider.send.apply(
            contract.currentProvider, arguments
        );
        };
    }

    contract.deployed().then(function(instance){
        return instance.yourFunction();
    }).then(response => {
        console.log(response);
    });
}