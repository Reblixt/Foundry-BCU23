// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract Counter {
    uint256 public number;
    string public name;

    error NumberGreaterThanTen();

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        require(number < 10, NumberGreaterThanTen());
        // if (number >= 10) revert NumberGreaterThanTen();
        number++;
    }

    function decrement() public {
        number--;
    }

    function setName(string memory newName) public {
        name = newName;
    }
}
