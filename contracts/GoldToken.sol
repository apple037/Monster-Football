// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;
import "./AddressCenter.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";

contract GoldToken is ERC20, Ownable{
    AddressCenter adrCenter;
    event GoldClaim(address user, uint amount);
    using SignatureChecker for *;
    mapping(uint256 => bool) public usedNonces;
    constructor(address centerAdr) ERC20("gold", "GD"){
        adrCenter = AddressCenter(centerAdr);
    }
    //initialize
    function mintGold(uint amount, uint nonce, bytes memory signature)
        public
        returns (uint256)
    {
        require(!usedNonces[nonce]);
        usedNonces[nonce] = true;
        bytes32 hash = getHash(msg.sender, amount, nonce);
        require(SignatureChecker.isValidSignatureNow(adrCenter.contracts("wallet"), hash, signature),"Amount error");
        _mint(msg.sender, amount);
        emit GoldClaim(msg.sender, amount);
        return amount;
    }
    function burnGold(uint amount)
        public
        returns (uint256)
    {
        _burn(msg.sender, amount * 10 ** 18);
        return amount;
    }
    function getHash(address to, uint256 amount, uint nonce) public view returns (bytes32) {
        return keccak256(abi.encodePacked(this,to,amount,nonce));
    }
}