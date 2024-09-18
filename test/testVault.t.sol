// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {Vault} from "src/Vault.sol";
import {BCU23Collection} from "src/ERC721.sol";

// import {MockERC721} from "forge-std/mocks/MockERC721.sol";

contract TestVault is Test {
    Vault vault;
    BCU23Collection collection;

    address public owner = vm.addr(0x1);
    address public Adam = vm.addr(0x2);
    address public Eve = vm.addr(0x3);

    string[] uris = ["uri1", "uri2", "uri3"];

    function setUp() public {
        vault = new Vault(owner);

        vm.prank(Adam);
        collection = new BCU23Collection(Adam, "metadata", uris);
    }

    function test_CreateVault() public {
        createVaultHelper();
        uint256 vaultNftIds = collection.balanceOf(address(vault));
        uint256 AdamsNFtCountAfterVault = collection.balanceOf(Adam);

        assertEq(vaultNftIds, 2);
        assertEq(AdamsNFtCountAfterVault, 1);
    }

    function test_VaultData() public {
        createVaultHelper();
        Vault.VaultData memory vaultData = vault.getVaultData(1);

        uint256 vaultId = vaultData.vaultId;
        address vaultOwner = vaultData.owner;
        uint256[] memory tokenIds = vaultData.tokenIds;
        uint256 deadline = vaultData.deadline;

        assertEq(vaultId, 1);
        assertEq(vaultOwner, Adam);
        assertEq(tokenIds.length, 2);
        assertEq(tokenIds[0], 1);
        assertEq(tokenIds[1], 2);
        assertEq(deadline, block.timestamp + 1 weeks);
    }

    function test_RetrieveNFTs() public {
        createVaultHelper();

        // förbereder vi att hämta nft
        uint256[] memory nftIds = new uint256[](1);
        nftIds[0] = 1;
        // nftIds[1] = 2;
        // vm.roll(2); // 2 nya blocks minars
        vm.warp(2 weeks); // 2 veckor har gått utan nya blocks
        vm.prank(Adam);
        vault.retrieveNFTs(1, nftIds);
    }

    ////////////// Helper Functions //////////////

    function createVaultHelper() public {
        uint256[] memory urisToStore = new uint256[](2);
        urisToStore[0] = 1;
        urisToStore[1] = 2;
        vm.startPrank(Adam);
        collection.approve(address(vault), 1);
        collection.approve(address(vault), 2);
        vault.createVault(address(collection), urisToStore, 1 weeks);

        vm.stopPrank();
    }
}
