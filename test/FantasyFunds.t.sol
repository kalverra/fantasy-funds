// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/FantasyFunds.sol";

contract CounterTest is Test {
    FantasyFunds public funds;
    address public owner = address(this);

    string mnemonic =
        "test test test test test test test test test test test junk";
    uint256 privateKey = vm.deriveKey(mnemonic, 0);
    address public player = vm.deriveAddress(privateKey, 0);

    function setUp() public {
        funds = new FantasyFunds("testLeague", 1);
    }

    function testfail_CannotBuyInLow() public {
        vm.expectRevert("Buy in must be equal to the buy in amount");
        funds.buyIn();
    }

    function test_BuyIn() public {
        funds.buyIn{value: 1}();
        assertEq(funds.totalBalance(), 1);
    }

    function test_Register() public {
        funds.registerPlayer("testPlayer", address(this));
        assertEq(
            keccak256(abi.encodePacked(funds.players(address(this)))),
            keccak256(abi.encodePacked("testPlayer"))
        );
    }

    function test_NonOwnerCantRegister() public {
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(player);
        funds.registerPlayer("testPlayer", address(this));
    }
}
