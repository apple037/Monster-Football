// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;

contract AddressCenter{
    
    struct property{
        bool isRebate;
        uint slippage;
        uint lp;
        uint burn;
        uint operator;
        uint rebate;
    }
    //modfier
    modifier onlyOperator{
        require(operators[msg.sender],"Require operator permission");
        _;
    }
    constructor(){
        operators[msg.sender] = true;
    }
    mapping(string => address) public contracts;
    mapping(address => property) public settings;
    mapping(address => bool) public operators;
    //設定營運者
    function addOperator(address op) public onlyOperator {
        operators[op] = true;
    }
    //取消營運者
    function cancelOperator(address op) public onlyOperator {
        operators[op] = false;
    }

    //新增地址mapping
    function addContractMapping(string memory name, address adr) public onlyOperator {
        contracts[name] = adr;
    }
    function addAddressSetting(bool isRebate, uint slippage, uint lp, uint burn, uint operator, uint rebate,address adr) public onlyOperator{
        require(slippage == lp + burn + operator + rebate, "slippage setting error");
        settings[adr] = property(isRebate, slippage, lp, burn, operator, rebate);
    }
    function getRebateState(address adr) public view returns(bool){
        return settings[adr].isRebate;
    }
    function getSlippage(address adr) public view returns(uint){
        return settings[adr].slippage;
    }
    function getRebate(address adr) public view returns(uint){
        return settings[adr].rebate;
    }
    function getLp(address adr) public view returns(uint){
        return settings[adr].lp;
    }
    function getBurn(address adr) public view returns(uint){
        return settings[adr].burn;
    }
    function getOperator(address adr) public view returns(uint){
        return settings[adr].operator;
    }
}