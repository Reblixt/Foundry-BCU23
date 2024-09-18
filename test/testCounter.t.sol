// SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;
import {Test, console} from "forge-std/Test.sol";
import {Counter} from "src/Counter.sol";

contract testCounter is Test {
    Counter counter;

    // Fungerar på samma sätt som mocka och jest
    // beforeEach
    function setUp() public {
        counter = new Counter();
    }

    //////////////////// Successful functions//////////////////
    function test_SetNumber() public {
        counter.setNumber(10);
        console.log("the number is", counter.number());

        vm.assertEq(counter.number(), 10);
        assert(counter.number() == 10);
    }

    function test_Increment() public {
        counter.setNumber(8);

        counter.increment();
        vm.assertEq(counter.number(), 9);
    }

    ////////////////// Revert function /////////////////
    function test_RevertWhenNumberGreatenThanTen() public {
        counter.setNumber(10);
        vm.expectRevert(Counter.NumberGreaterThanTen.selector);
        counter.increment();
    }
}
