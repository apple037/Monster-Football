// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;

contract Pancake{
    function getReserves() public pure returns (uint112 _reserve0, uint112 _reserve1, uint32 _blockTimestampLast){
        uint112 r0 = 100;
        uint112 r1 = 100;
        uint32 time = 999;
        return (r0, r1, time);
    }
}