var MFBToken = artifacts.require("./MFBToken.sol");
var Gold = artifacts.require("./GoldToken.sol");
var MFBPool = artifacts.require("./MFBPool.sol");
var MFEToken = artifacts.require("./MFEToken.sol");
var NFTMarket = artifacts.require("./NFTMarket.sol");
var BlindBox = artifacts.require("./BlindBox.sol");
var Rebate = artifacts.require("./RebatePool.sol");
var Channel = artifacts.require("./TokenChannel.sol");
var Access = artifacts.require("./Access.sol");
var AddressCenter = artifacts.require("./AddressCenter.sol");

let box = await BlindBox.deployed();
let gd = await Gold.deployed();
let pool = await MFBPool.deployed();
let mfe = await MFEToken.deployed();
let mfb = await MFBToken.deployed();
let rebate = await Rebate.deployed();
let channel = await Channel.deployed();
let access = await Access.deployed();
let market = await NFTMarket.deployed();
let center = await AddressCenter.deployed();
let msg = "box: " + box.address + "\n";
msg += "gold: " + gd.address + "\n";
msg += "pool " + pool.address + "\n";
console.log(msg)