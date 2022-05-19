// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;
pragma abicoder v2;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./IMFEToken.sol";
import "./IMFBToken.sol";
import "./MFBPool.sol";
import "./AddressCenter.sol";
import "./IPancake.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./RebatePool.sol";
import "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";

contract BlindBox is Ownable{   
    //address
    AddressCenter adrCenter;
    address public zero = address(0);
    constructor(address centerAdr){
        adrCenter = AddressCenter(centerAdr);
    }
    //address end
    //variables
    using SafeMath for uint256;
    using Counters for Counters.Counter;
	Counters.Counter private _adIds;     
    struct advertise{
        uint id;
        uint startTime;
        uint endTime;
        string name;
        uint price;
        bool state;
        uint amount;
        uint boxType;
    }
    uint[] all_record;
    uint[] on_sale;
    //fee setting
    uint public burnRate = 0;
    uint public op_fee = 88;
    uint public pool_fee = 0;
    uint public invite_fee = 12;
    uint public adDecimal = 6;
    uint public calPriceDecimal = 12;
    address [] users;
    mapping(uint => advertise) public advertises;
    mapping(uint256 => bool) public usedNonces;
    //event
    event buyBox(uint adId, address buyer, uint price, uint amount, uint indexed total, uint reward, uint agent, uint operator, uint burn);
    event changeBoxState(uint adId, bool state);
    event openBox(uint [] ids, address buyer);
    event addAd(uint id, string name, uint startTime, uint endTime, uint price, bool state, uint amount, uint boxType);
    //fee setting
    function setBurnRate (uint rate) public returns (bool) {
        require(adrCenter.operators(msg.sender),"Require operator permission");
        burnRate = rate;
        return true;
    }
    function setOpFee (uint rate) public returns (bool) {
        require(adrCenter.operators(msg.sender),"Require operator permission");
        op_fee = rate;
        return true;
    }
    function setPoolRate (uint rate) public returns (bool) {
        require(adrCenter.operators(msg.sender),"Require operator permission");
        pool_fee = rate;
        return true;
    }
    function setInviteRate (uint rate) public returns (bool) {
        require(adrCenter.operators(msg.sender),"Require operator permission");
        invite_fee = rate;
        return true;
    }
    function setDecimal (uint _adDecimal, uint _calPriceDecimal) public returns (bool) {
        require(adrCenter.operators(msg.sender),"Require operator permission");
        adDecimal = _adDecimal;
        _calPriceDecimal = _calPriceDecimal;
        return true;
    }
    //fee setting end
    //紀錄盲盒狀態
    function addAdvertise(string memory name,uint startTime, uint endTime, uint price, bool state, uint amount, uint boxType)
    public
    returns (uint)
    {
        require(adrCenter.operators(msg.sender),"Require operator permission");
        _adIds.increment();
        uint256 id = _adIds.current();
        advertises[id].id = id;
        advertises[id].name = name;
        advertises[id].startTime = startTime;
        advertises[id].endTime = endTime;
        advertises[id].price = price; // BUSD計價
        advertises[id].state = state;
        advertises[id].amount = amount;
        advertises[id].boxType = boxType;
        emit addAd(id,name,startTime,endTime,price,state,amount,boxType);
        return id;
    }
    function setState(uint id, bool state) public{
        require(adrCenter.operators(msg.sender),"Require operator permission");
        require(advertises[id].state != state,"Same state");
        advertises[id].state = state;
        emit changeBoxState(id, state);
    }
    function time() public view returns (uint){
        return block.timestamp;
    }
    function buyBoxByMFB(uint id, uint amount, uint price, uint nonce, bytes memory signature) public{
        require(advertises[id].amount >= amount,"remain box is not enough");
        require(advertises[id].startTime < time(),"Blind box selling is not yet started.");
        require(advertises[id].endTime > time(),"Blind box selling is end");
        require(advertises[id].state == true,"Blind box selling is closed");
        require(!usedNonces[nonce]);
        usedNonces[nonce] = true;
        bytes32 hash = getHash(msg.sender, amount, nonce);
        require(SignatureChecker.isValidSignatureNow(adrCenter.contracts("wallet"), hash, signature),"Amount error");
        uint variablePrice = price.mul(100).div(calPrice());
        uint hundred = 100;
        uint finalPrice = price > calPrice() ? variablePrice.sub(100) : hundred.sub(variablePrice); 
        require(finalPrice < 5,"Price Error!");
        //Token transfer
        uint total = amount.mul(advertises[id].price).mul(calPrice()); // calculate the total amount divide 100
        //uint percent = pool_fee + invite_fee + op_fee; // skip divide 100 
        //獎勵池
        if(pool_fee > 0){
            IERC20(adrCenter.contracts("mfbToken")).transferFrom(msg.sender,adrCenter.contracts("rewardPool"), total.mul(pool_fee).div(100));  
        }
        //反傭池
        IERC20(adrCenter.contracts("mfbToken")).transferFrom(msg.sender,adrCenter.contracts("rebatePool"), total.mul(invite_fee).div(100));  
        //錢包
        IERC20(adrCenter.contracts("mfbToken")).transferFrom(msg.sender,adrCenter.contracts("wallet"),total.mul(op_fee).div(100));
        //焚燒
        if(burnRate > 0) {
            IERC20(adrCenter.contracts("mfbToken")).transferFrom(msg.sender,address(this),total.mul(burnRate).div(100));
            IMFBToken(adrCenter.contracts("mfbToken")).burn(total.mul(burnRate).div(100));
        }
        emit buyBox(id,msg.sender, calPrice(), amount, total, total.mul(pool_fee).div(100), total.mul(invite_fee).div(100), total.mul(op_fee).div(100), total.mul(burnRate).div(100));
        for(uint i=0; i< amount; i++){
            IMFEToken(adrCenter.contracts("mfeToken")).openBox(id,msg.sender);
        }
        advertises[id].amount -= amount;
    }
    function calPrice() public view returns (uint){
        uint r1;
        uint r2;
        uint b;
        (r1, r2, b) = IPancake(adrCenter.contracts("pancake")).getReserves();
        r2 = r2.mul(10 ** calPriceDecimal);
        r2 = r2.div(r1);
        return r2;
    }

    function getHash(address to, uint256 amount, uint nonce) public view returns (bytes32) {
        return keccak256(abi.encodePacked(this,to,amount,nonce));
    }
}