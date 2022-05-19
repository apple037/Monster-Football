// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./IMFBToken.sol";
import "./IMFEToken.sol";
import "./AddressCenter.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
contract NFTMarket{
    //address
    AddressCenter adrCenter;
    constructor(address centerAdr){
        adrCenter = AddressCenter(centerAdr);
    }
    using SafeMath for uint256;
    //variables
    struct info{
        uint price;
        address tokenAdr;
    }
    mapping(uint => bool) public selling;
    mapping(uint => info) public infos;
    uint public burnRate = 4;
    uint public pool_fee = 4;
    uint public op_fee = 2;
    //event
    event toAddress(address buyer, uint amount, string t_type);
    event buyOrSell(bool isSell, address seller, uint id, uint price, address tokenAdr);
    event totalTransfer(address from, uint reward, uint agent, uint operator, uint burn, address tokenAdr,address owner);
    event close(uint id);

    //fee setting
    function setBurn (uint rate) public returns (bool) {
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
    function getRate () public view returns (uint) {
        return burnRate + op_fee + pool_fee;
    }
    //fee setting end
    //拍賣NFT
    function sellNFT(uint id, uint price, address tokenAdr) public{
        require(IERC721(adrCenter.contracts("mfeToken")).ownerOf(id) == msg.sender,"Your're not the token owner");
        require(selling[id] == false,"NFT is already on sale");
        require(IMFEToken(adrCenter.contracts("mfeToken")).getState(id) == 0,"This nft is not available for sale now");
        require(IERC721(adrCenter.contracts("mfeToken")).getApproved(id) == address(this),"This token is not yet approved to the contract");
        selling[id] = true;
        infos[id].price = price;
        infos[id].tokenAdr = tokenAdr;
        IMFEToken(adrCenter.contracts("mfeToken")).stateChangeMarket(id,3);
        emit buyOrSell(true, msg.sender, id, price, tokenAdr);
    }
    //購買NFT
    function buyNFT(uint id) public{
        require(IERC20(infos[id].tokenAdr).balanceOf(msg.sender) >= infos[id].price,"You don't have enough MFB to buy this NFT");
        require(selling[id] == true,"NFT is not on sale");
        address ori_owner = IERC721(adrCenter.contracts("mfeToken")).ownerOf(id);
        //ERC20 transfer
        uint actual = 100 - burnRate - pool_fee - op_fee;
        IERC20(infos[id].tokenAdr).transferFrom(msg.sender,ori_owner,actual.mul(infos[id].price).div(100));
        IERC20(infos[id].tokenAdr).transferFrom(msg.sender,adrCenter.contracts("rewardPool"), pool_fee.mul(infos[id].price).div(100));
        IERC20(infos[id].tokenAdr).transferFrom(msg.sender,adrCenter.contracts("wallet"),op_fee.mul(infos[id].price).div(100));
        // 焚燒 因有些Token沒有實作burn 故先轉至一個地址存放
        IERC20(infos[id].tokenAdr).transferFrom(msg.sender,adrCenter.contracts("burn"),burnRate.mul(infos[id].price).div(100));
        //IMFBToken(adrCenter.contracts("mfbToken")).burn(infos[id].price.div(100).mul(burnRate));
        //721
        IMFEToken(adrCenter.contracts("mfeToken")).stateChangeMarket(id,0);
        IERC721(adrCenter.contracts("mfeToken")).safeTransferFrom(ori_owner,msg.sender,id);      
        emit buyOrSell(false, msg.sender, id, infos[id].price, infos[id].tokenAdr);
        emit totalTransfer(msg.sender, pool_fee.mul(infos[id].price).div(100), 0, op_fee.mul(infos[id].price).div(100), burnRate.mul(infos[id].price).div(100), infos[id].tokenAdr,ori_owner);
        selling[id] = false;
        infos[id].price = 0;
    }
    //中止拍賣
    function endSale(uint id) public{
        require(selling[id] == true,"NFT is not on sale");
        require(IERC721(adrCenter.contracts("mfeToken")).ownerOf(id) == msg.sender,"Your're not the token owner");
        emit close(id);
        selling[id] = false;
        infos[id].price = 0;
        IMFEToken(adrCenter.contracts("mfeToken")).stateChangeMarket(id,0);
    }
}