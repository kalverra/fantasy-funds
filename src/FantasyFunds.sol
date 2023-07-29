// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract FantasyFunds is Ownable {
    string public leagueName;
    uint public totalBalance;
    uint public buyInAmount;

    mapping(address => bool) public boughtIn; // player address => bought in yet (true/false)
    mapping(address => string) public players; // player address => player user name

    constructor(string memory _leagueName, uint _buyInAmount) {
        require(_buyInAmount > 0, "Buy in amount must be greater than 0");
        leagueName = _leagueName;
        buyInAmount = _buyInAmount;
    }

    function buyIn() public payable {
        require(
            msg.value == buyInAmount,
            "Buy in must be equal to the buy in amount"
        );
        require(
            !boughtIn[msg.sender],
            "You have already bought in to this league"
        );
        require(
            keccak256(abi.encodePacked(players[msg.sender])) !=
                keccak256(abi.encodePacked("")),
            "You must register to buy in"
        );
        boughtIn[msg.sender] = true;
        totalBalance += msg.value;
    }

    function registerPlayer(
        string memory _playerName,
        address _address
    ) public onlyOwner {
        players[_address] = _playerName;
    }
}
