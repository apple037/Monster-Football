// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;

interface IMFEToken{
    function combination(uint tokenId_1,uint tokenId_2,address caller,string memory tokenURI) external returns (uint256);
    function openBox(uint adId, address caller) external returns (uint);
    function getState(uint tokenId) external returns (uint);
    function stateChangeMarket(uint id, uint state) external;
}