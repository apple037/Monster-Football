// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "./contracts/access/Ownable.sol";
import "./contracts/token/ERC721/IERC721.sol";
import "./Access.sol";
import "./contracts/utils/math/SafeMath.sol";
import "./IGoldToken.sol";
import "./IMFEToken.sol";
import "./AddressCenter.sol";
import "./TokenChannel.sol";

contract GoldPool is Ownable{
    using SafeMath for uint256;
    //variables
    uint public hello = 0;
    mapping(uint => uint) public id2blocks; //紀錄Token打工開始的區塊號碼
    AddressCenter adrCenter = AddressCenter(0x1028f250EB47Fd7aaf36820967ec51D198559F71);
    Access acs = Access(0x88C96DCcD894E4bcb152eE26ab37888936f47074);
    address _gold_adr;
    address _nft_contract;
    address _token_channel;
    event GoldClaim(address user, uint amount);
    //modfier
    modifier onlyOperator{
        require(acs.operators(msg.sender),"Require operator permission");
        _;
    }
    //initialize
    function initialize_adr() public onlyOperator {
        _gold_adr = adrCenter.gold();
        _nft_contract = adrCenter.nft();
        _token_channel = adrCenter.channel();
    }
    function claimGold (uint amount, uint nonce, bytes memory signature) public{
        IGoldToken(_gold_adr).mintGold(msg.sender,amount);
        emit GoldClaim(msg.sender, amount);
    }   
    /*On Chain 
    function startPartTime(uint tokenId) public{
        require(IERC721(_nft_contract).ownerOf(tokenId) == msg.sender,"You are not the token owner");
        require(IMFEToken(_nft_contract).getState(tokenId) == 0,"This NFT is not available now");
        IMFEToken(_nft_contract).stateChange(tokenId,1);
        id2blocks[tokenId] = block.number;
    }
    function endPartTime(uint tokenId) public{
        require(IERC721(_nft_contract).ownerOf(tokenId) == msg.sender,"You are not the token owner");
        require(IMFEToken(_nft_contract).getState(tokenId) == 1,"This NFT is not on part time job now");
        IMFEToken(_nft_contract).stateChange(tokenId,0);
        uint reward = block.number.sub(id2blocks[tokenId]);
        addReward(reward);
        id2blocks[tokenId] = 0;
    }
    function addBlock () public returns (uint) {
        hello = hello.add(1);
        return block.number;
    }
    */
}