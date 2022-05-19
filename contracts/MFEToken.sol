// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./AddressCenter.sol";
import "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";

contract MFEToken is ERC721, Ownable{
    //variables
    using Counters for Counters.Counter;
    using SignatureChecker for *;
    using Strings for uint256;
	Counters.Counter private _tokenIds;
    struct monster{
        uint reproduction;
        uint ap;
    }
    mapping(uint => monster) public monsters;
    mapping(uint => uint) public states; 
    mapping(uint256 => bool) public usedNonces;
    /**
    0: normal
    1: working
    2: dead
    3: selling
    4: inGame 
    **/
    //address
    AddressCenter adrCenter;
    bool public is_init = false;
    string public uriPrefix = "test";
    uint public totalSupply = 0;
    string public _baseURIExtended;
    //event
    event mintDone(uint adId, address owner,uint id);
    event combineDone(address owner,uint id);
    event stateChg(uint id, uint state);
    constructor(address centerAdr) ERC721("Monster Football Egg","MFE"){
        adrCenter = AddressCenter(centerAdr);
    }
    function mintNFT(address recipient)
    private
    returns (uint256)
    {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        monsters[newItemId].reproduction = 7;
        states[newItemId] = 0;
        _safeMint(recipient, newItemId);
        totalSupply += 1;
        return newItemId;
    }
    function burnNFT(uint256 tokenId)
        public
    {
        require(adrCenter.operators(msg.sender),"Require operator permission");
        _burn(tokenId);
        totalSupply -= 1;
    }
    //合併NFT
    function combination(uint tokenId_1,uint tokenId_2,address caller)
    external
    returns (uint256)
    {
        require(ownerOf(tokenId_1) == caller,"you are not token owner!");
        require(ownerOf(tokenId_2) == caller,"you are not token owner!");
        require(monsters[tokenId_1].reproduction > 0,"Remain times insufficient!");
        require(monsters[tokenId_2].reproduction > 0,"Remain times insufficient!");
        monsters[tokenId_1].reproduction -= 1;
        monsters[tokenId_2].reproduction -= 1;
        mintNFT(caller);
        emit combineDone(msg.sender,_tokenIds.current());
        return _tokenIds.current();
    }
    //盲盒轉NFT
    function openBox(uint adId, address caller) external returns (uint) {
        require(msg.sender == adrCenter.contracts("blindbox"),"This function can only be triggered by blind box contract!");
        uint256 newItemId = _tokenIds.current() + 1;
        mintNFT(caller);
        emit mintDone(adId, caller, newItemId);
        return _tokenIds.current();
    }
    //transfer
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        require(states[tokenId] == 0,"NFT is not available");
        _transfer(from, to, tokenId);
    }
    function stateChangeMarket(uint id, uint state) external{
        if(msg.sender == adrCenter.contracts("market")){
            states[id] = state;
            emit stateChg(id, state);
        }
    }
    function stateChangeUser(uint id, uint state, uint nonce, bytes memory signature) external{
        require(!usedNonces[nonce]);
        usedNonces[nonce] = true;
        bytes32 hash = getHash(msg.sender, id , state, nonce);
        require(SignatureChecker.isValidSignatureNow(adrCenter.contracts("wallet"), hash, signature),"Signature error");
        states[id] = state;
        emit stateChg(id, state);
    }
    //get state of nft
    function getState(uint tokenId) public view returns(uint) {
        return states[tokenId];
    }
    function setBaseURI(string memory baseURI_) public{
        require(adrCenter.operators(msg.sender),"Require operator permission");
        _baseURIExtended = baseURI_;
    }

    function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory base = _baseURIExtended;
        require(bytes(base).length != 0, "baseURI not set");
        return string(abi.encodePacked(base, tokenId.toString()));
    }

    function getHash(address to, uint id, uint state, uint nonce) public view returns (bytes32) {
        return keccak256(abi.encodePacked(this,to,id,state,nonce));
    }
}