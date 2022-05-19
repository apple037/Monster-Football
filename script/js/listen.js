const Web3 = require("web3")
const web3 = new Web3("https://data-seed-prebsc-1-s1.binance.org:8545/")

var box_adr = '0xfcE936253D3930d69446ddd4839808a6E4E01c31';
var blindboxContract = new web3.eth.Contract([{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"id","type":"uint256"},{"indexed":false,"internalType":"string","name":"name","type":"string"},{"indexed":false,"internalType":"uint256","name":"startTime","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"endTime","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"price","type":"uint256"},{"indexed":false,"internalType":"bool","name":"state","type":"bool"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"addAd","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"buyer","type":"address"},{"indexed":false,"internalType":"uint256","name":"price","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"buyBox","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"adId","type":"uint256"}],"name":"closeBox","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"buyer","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"},{"indexed":false,"internalType":"string","name":"t_type","type":"string"}],"name":"toAddress","type":"event"},{"inputs":[],"name":"AllList","outputs":[{"internalType":"uint256[]","name":"","type":"uint256[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"_mfb_adr","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"_nft_contract","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"_op_wallet","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"_pancake_adr","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"_pool_adr","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"_rebate_adr","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"_token_channel","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"name","type":"string"},{"internalType":"uint256","name":"startTime","type":"uint256"},{"internalType":"uint256","name":"endTime","type":"uint256"},{"internalType":"uint256","name":"price","type":"uint256"},{"internalType":"bool","name":"state","type":"bool"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"addAdvertise","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"advertises","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"uint256","name":"startTime","type":"uint256"},{"internalType":"uint256","name":"endTime","type":"uint256"},{"internalType":"string","name":"name","type":"string"},{"internalType":"uint256","name":"price","type":"uint256"},{"internalType":"bool","name":"state","type":"bool"},{"internalType":"uint256","name":"amount","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"box_per_day","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"burnRate","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"uint256","name":"price","type":"uint256"},{"internalType":"uint256","name":"nonce","type":"uint256"},{"internalType":"bytes","name":"signature","type":"bytes"}],"name":"buyBoxByMFB","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"calPrice","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getList","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"initialize_adr","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"invite_fee","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"op_fee","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pool_fee","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"pushIn","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"renounceOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"resetAllBox","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"rate","type":"uint256"}],"name":"setBurnRate","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"}],"name":"setClose","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"rate","type":"uint256"}],"name":"setInviteRate","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"rate","type":"uint256"}],"name":"setOpFee","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"rate","type":"uint256"}],"name":"setPoolRate","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"time","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"zero","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"}],box_adr);
blindboxContract.events.allEvents({
    fromBlock: 'latest'
}, function(error, events){ console.log(events); })