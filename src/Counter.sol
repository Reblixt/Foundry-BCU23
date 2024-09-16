// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

contract Counter {
    uint256 public number;
    string public name;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        // if (number >= 10) revert("Number is greater than 10");
        number++;
    }

    function decrement() public {
        number--;
    }

    function setName(string memory newName) public {
        name = newName;
    }
}
