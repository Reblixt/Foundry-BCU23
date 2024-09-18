// SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;

import {Test, console} from "forge-std/Test.sol";
import {BCU23Collection} from "src/ERC721.sol";

contract TestERC721 is Test {
    BCU23Collection nftCollection;
    address owner = vm.addr(0x1);
    address Adam = vm.addr(0x2);
    address Rasmus = vm.addr(0x3);

    string contractUri = "https://example.com/contract";
    string[] uris = new string[](4);

    function setUp() public {
        // enkilda nft/tokens Har namn, url till bild,
        uris[0] = "https://example.com/1";
        uris[1] = "https://example.com/2";
        uris[2] = "https://example.com/3";
        uris[3] = "https://example.com/4";

        nftCollection = new BCU23Collection(owner, contractUri, uris);
        // console.log("who is caller", msg.sender);
    }

    function test_Pause() public {
        vm.prank(owner);
        // kommer owner vara msg.sender
        nftCollection.pause();
        vm.assertTrue(nftCollection.paused() == true);
    }

    function test_UnPause() public {
        vm.startPrank(owner);
        // Alla anrop innanför prank kommer vara owner
        // som är msg.sender

        nftCollection.pause();
        nftCollection.unpause();

        vm.stopPrank();

        vm.assertTrue(nftCollection.paused() == false);
    }

    function test_SafeMint() public {
        vm.startPrank(owner);
        nftCollection.safeMint(Adam, "https://example.com/5");

        string memory ContractURI = nftCollection.contractURI();
        string memory tokenURI = nftCollection.tokenURI(5);

        vm.assertEq(
            ContractURI,
            "data:application/json;utf8,https://example.com/contract"
        );
        vm.assertEq(tokenURI, "https://example.com/5");
        vm.stopPrank();
    }
}
