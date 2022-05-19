// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BUSD is ERC20, Ownable{
    constructor() ERC20("test U", "BUSD"){
        _mint(msg.sender, 100000000000 * 10 ** 18);
    }
    //initialize
    function mint(uint amount)
        public
        returns (uint256)
    {
        _mint(msg.sender, amount);
        return amount;
    }
    function burnGold(uint amount)
        public
        returns (uint256)
    {
        _burn(msg.sender, amount * 10 ** 18);
        return amount;
    }
}