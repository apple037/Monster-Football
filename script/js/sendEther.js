const Web3 = require("web3")
const web3 = new Web3("http://127.0.0.1:8545")
var wallet = '0xe798505BF9158Ba14D687877F96e99890e7580D3';
var wallet2 = '0x764b1B6B0562406a06b4923e99e25418360F54e6';
var accounts;
var sender;
console.log(wallet);
web3.eth.getAccounts().then(function(response) { 
    accounts = response; 
    sender = accounts[0];
    console.log(sender)
    web3.eth.defaultAccount = sender;
    web3.eth.sendTransaction({to:wallet, from:sender, value:web3.utils.toWei("10", "ether")})
    //web3.eth.sendTransaction({to:wallet2, from:sender, value:web3.utils.toWei("10", "ether")})
});


