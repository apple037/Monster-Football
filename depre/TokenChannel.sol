// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract TokenChannel {
    address public sender;      // The account sending payments.
    address public operator = 0xe798505BF9158Ba14D687877F96e99890e7580D3;
    mapping(uint256 => bool) public usedNonces;
    mapping(uint256 => bool) public usedBoxNonces;
    constructor ()
    {
        sender = msg.sender;
    }

    /// the recipient can close the channel at any time by presenting a
    /// signed amount from the sender. the recipient will be sent that amount,
    function check(address to, uint256 amount, uint nonce, bytes memory signature) external returns (bool){
        require(!usedNonces[nonce]);
        usedNonces[nonce] = true;
        require(isValidSignature(to, amount ,nonce, signature));  
        return true; 
    }

    function getHash(address to, uint256 amount, uint nonce) public view returns(bytes32){
        return keccak256(abi.encodePacked(this,to,amount,nonce));
    }

    function checkHash(address to, uint256 amount, uint nonce, bytes memory signature) public view returns(bool){
        return isValidSignature(to, amount ,nonce, signature);
    }

    function isValidSignature(address to, uint256 amount, uint nonce, bytes memory signature)
        internal
        view
        returns (bool)
    {
        bytes32 message = prefixed(keccak256(abi.encodePacked(this,to,amount,nonce)));

        // check that the signature is from the payment sender
        return recoverSigner(message, signature) == operator;
    }

    /// All functions below this are just taken from the chapter
    /// 'creating and verifying signatures' chapter.

    function splitSignature(bytes memory sig)
        internal
        pure
        returns (uint8 v, bytes32 r, bytes32 s)
    {
        require(sig.length == 65);

        assembly {
            // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }
        return (v, r, s);
    }

    function recoverSigner(bytes32 message, bytes memory sig)
        internal
        pure
        returns (address)
    {
        (uint8 v, bytes32 r, bytes32 s) = splitSignature(sig);
        return ecrecover(message, v, r, s);
    }

    /// builds a prefixed hash to mimic the behavior of eth_sign.
    function prefixed(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
}