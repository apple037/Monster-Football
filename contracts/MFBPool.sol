// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./MFBToken.sol";
import "./AddressCenter.sol";
import "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";

contract MFBPool is Ownable{
    AddressCenter adrCenter;
    constructor(address centerAdr){
        adrCenter = AddressCenter(centerAdr);
    }
    //address
    mapping(uint256 => bool) public usedNonces;
    using SignatureChecker for *;
    //event
    event claimRewardEvent(address user, uint amount, string reward_type);
    //領取獎勵
    //You can only take your portion.
    function claimReward(uint amount, uint nonce, bytes memory signature)
    public
    returns(bool)
    {
        require(IERC20(adrCenter.contracts("mfbToken")).balanceOf(address(this)) >= amount,"Not enough token supply!");
        require(!usedNonces[nonce]);
        usedNonces[nonce] = true;
        bytes32 hash = getHash(msg.sender, amount, nonce);
        require(SignatureChecker.isValidSignatureNow(adrCenter.contracts("wallet"), hash, signature),"Amount error");
        MFBToken(adrCenter.contracts("mfbToken")).approve(msg.sender,amount);
        MFBToken(adrCenter.contracts("mfbToken")).transfer(msg.sender,amount);
        emit claimRewardEvent(msg.sender,amount,"reward");
        //IMFBToken(token_adr).cleanApprove(msg.sender);
        return true;
    }

    function checkAcs(address adr) public view returns (bool) {
        return adrCenter.operators(adr);
    }
    //Contract balance 
    function c_bal() public view returns (uint){
        return IERC20(adrCenter.contracts("mfbToken")).balanceOf(address(this));
    }

    function getHash(address to, uint256 amount, uint nonce) public view returns (bytes32) {
        return keccak256(abi.encodePacked(this,to,amount,nonce));
    }
}