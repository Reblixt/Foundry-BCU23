// SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;

import {Test, console} from "forge-std/Test.sol";
import {FactoryERC721} from "src/FactoryERC721.sol";
import {BCU23Collection} from "src/ERC721.sol";

contract TestFactoryERC721 is Test {
    BCU23Collection nftCollection;
    FactoryERC721 factory;

    address owner = vm.addr(0x1);
    address Adam = vm.addr(0x2);
    address Rasmus = vm.addr(0x3);

    string contractUri = "https://example.com/contract";
    string[] uris = new string[](2);

    function setUp() public {
        factory = new FactoryERC721();
        uris[0] = "https://example.com/1";
        uris[1] = "https://example.com/2";

        vm.prank(Adam);
        factory.createCollection(contractUri, uris);
    }

    function test_CreateNewCollection() public {
        string[] memory newuris = new string[](2);
        uris[0] = "https://example.com/3";
        uris[1] = "https://example.com/4";
        vm.prank(Rasmus);
        BCU23Collection collection = factory.createCollection(
            contractUri,
            newuris
        );

        BCU23Collection collection2 = factory.getCollection(2);

        vm.assertTrue(address(collection) == address(collection2));
    }
}
