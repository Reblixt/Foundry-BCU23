// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {Script, console} from "forge-std/Script.sol";
import {BCU23Collection} from "src/ERC721.sol";

contract DeployERC721 is Script {
    address public owner = 0x68B0fcF47729688097709d98Fa4DEc4643A96959;
    string public stringContractURI =
        '{"name": "Carls Developer Envoriment","symbol": "CDE","description": "This is a collection of Carls RL Developer Envoriment which includes a lot of cool stuff and ergonomictool", "image": "https: //i.postimg.cc/wMJ8k7qT/DevMouse.jpg", "banner_image_url": "https://i.postimg.cc/G2LCdcxX/DevSetUp.jpg", "sample_images": ["https://i.postimg.cc/wMJ8k7qT/DevMouse.jpg","https: //i.postimg.cc/G2LCdcxX/DevSetUp.jpg"],"github": "https://github.com/Reblixt"}';

    function run() public {
        string[] memory uriArray = new string[](2);
        uriArray[
            0
        ] = 'data:application/json;utf8,{"name": "DevMouse", "description": "Image of DevMouse", "image": "https://i.postimg.cc/wMJ8k7qT/DevMouse.jpg"}';
        uriArray[
            1
        ] = 'data:application/json;utf8,{"name": "DevMic", "description": "Image of DevMouse", "image": "https://i.postimg.cc/G2TGq1Zm/DevMic.jpg"}';

        vm.startBroadcast();
        BCU23Collection collection = new BCU23Collection(
            owner,
            stringContractURI,
            uriArray
        );

        string memory URI = collection.contractURI();
        string memory tokenURIOne = collection.tokenURI(1);
        string memory tokenURITwo = collection.tokenURI(2);

        vm.stopBroadcast();

        console.log(
            "Deployed BCU23Collection at address: ",
            address(collection)
        );

        console.log("Contract URI: ", URI);

        console.log("Token URI for token 1: ", tokenURIOne);
        console.log("Token URI for token 2: ", tokenURITwo);
    }
}
