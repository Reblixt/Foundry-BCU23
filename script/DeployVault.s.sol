// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Vault} from "src/Vault.sol";
import {Script, console} from "forge-std/Script.sol";

contract DeployVault is Script {
    address public MyAddress = 0x68B0fcF47729688097709d98Fa4DEc4643A96959;

    function run() public {
        vm.startBroadcast();
        Vault vault = new Vault(MyAddress);
        vm.stopBroadcast();

        console.log("Vault contract address: ", address(vault));
    }
}

contract CreateVault is Script {
    address vaultContractAddress;
    address MyAddress = 0x68B0fcF47729688097709d98Fa4DEc4643A96959;
    uint256[] tokenIds;
    uint256 deadline = 1 weeks;

    function run() public {
        tokenIds[0] = 1;
        tokenIds[1] = 2;
        tokenIds[2] = 3;

        vm.startBroadcast();
        Vault vault = Vault(vaultContractAddress);
        vault.createVault(MyAddress, tokenIds, 100);
        vm.stopBroadcast();

        console.log("Vault owner: ", MyAddress);
        console.log("Vault deadline: ", deadline);
        for (uint256 i = 0; i < tokenIds.length; i++) {
            console.log("Token ID: ", tokenIds[i]);
        }
    }
}
