// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "src/Counter.sol";

contract TestCounter is Test {
    Counter deployer = new Counter();

    function setUp() public {
        deployer.setNumber(10);
        deployer.setName("Counter");
    }

    function testIncrement() public {
        vm.expectRevert(Counter.NumberGreaterThanTen.selector);
        deployer.increment();
    }
}
