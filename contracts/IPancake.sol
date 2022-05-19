// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;

interface IPancake{
    function getReserves() external view returns (uint112 _reserve0, uint112 _reserve1, uint32 _blockTimestampLast);
}