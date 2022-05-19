// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;

interface IMFBToken{
    function burnOnBuy(address caller, uint amount) external returns (bool);
    function mint(uint amount) external returns (bool);
    function approve2Contract(address adr,uint amount) external returns (uint);
    function cleanApprove(address adr) external returns (uint);
    function burn(uint amount) external;
}