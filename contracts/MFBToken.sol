// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./AddressCenter.sol";
import "./MFBPool.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
contract MFBToken is ERC20, Ownable{  
    //address
    AddressCenter adrCenter;
    using SafeMath for uint256;
    // local
    event pancakeTrans(address from,address to,uint amount);
    constructor(address centerAdr) ERC20("monster football token", "MFB"){
        adrCenter = AddressCenter(centerAdr);
        _mint(msg.sender, 300000000 * 10 ** 18);
    }
    function burn(uint amount) external{
        // 若總數小於1.5億無法焚燒
        if(totalSupply() <= 150000000 * 10 ** 18){
            amount = 0;
        }
        _burn(msg.sender,amount);
    }
    function getAdr() public view returns (address){
        return adrCenter.contracts("rebatePool");
    }
    function mint(uint amount) public returns (bool){
        require(adrCenter.operators(msg.sender),"Require operator permission");
        //this function should not be used because it will break the supply of mfb
        _mint(address(this),amount);
        return true;
    }
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        if(adrCenter.getRebateState(msg.sender)){
            uint slippage = adrCenter.getSlippage(msg.sender);
            uint residual = 100 - slippage;
            uint rebate = adrCenter.getRebate(msg.sender);
            uint lp = adrCenter.getLp(msg.sender);
            uint burnRate = adrCenter.getBurn(msg.sender);
            uint wallet = adrCenter.getOperator(msg.sender);
            super.transfer(recipient, amount.div(100).mul(residual));
            super.transfer(adrCenter.contracts("rebatePool"), amount.div(100).mul(rebate));
            super.transfer(adrCenter.contracts("lpPool"), amount.div(100).mul(lp));
            super.transfer(adrCenter.contracts("wallet"), amount.div(100).mul(wallet));
            super.transfer(address(this), amount.div(100).mul(burnRate));
            this.burn(amount.div(100).mul(burnRate));
        }
        else{
            super.transfer(recipient, amount);
        }
        return true;
    }
}