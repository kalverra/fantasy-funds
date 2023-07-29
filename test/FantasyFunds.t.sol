// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/FantasyFunds.sol";

contract CounterTest is Test {
    FantasyFunds public funds;

    function setUp() public {
        funds = new FantasyFunds();
    }
}