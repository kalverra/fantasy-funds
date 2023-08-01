// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "../src/FantasyFund.sol";

contract FantasyFundTest is Test {
    FantasyFund public fund;
    address public owner = address(this);
    address public alice = makeAddr("alice");

    function setUp() public {
        fund = new FantasyFund("testLeague", 1);
    }

    function testfail_CantBuyInLow() public {
        fund.registerPlayer("alice", alice);
        vm.expectRevert("Buy in must be equal to the buy in amount");
        fund.buyIn();
    }

    function testfail_CantBuyInHigh() public {
        fund.registerPlayer("alice", alice);
        vm.expectRevert("Buy in must be equal to the buy in amount");
        fund.buyIn{value: 2}();
    }

    function test_BuyIn() public {
        fund.registerPlayer("alice", alice);
        vm.deal(alice, 1 ether);
        vm.prank(alice);
        fund.buyIn{value: 1}();
        assertEq(fund.totalBalance(), 1);
    }

    function test_Register() public {
        fund.registerPlayer("testPlayer", address(this));
        assertEq(
            keccak256(abi.encodePacked(fund.players(address(this)))),
            keccak256(abi.encodePacked("testPlayer"))
        );
    }

    function test_CantRegisterAsNonOwner() public {
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(alice);
        fund.registerPlayer("alice", alice);
    }
}
