// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import {BCU23Collection} from "./ERC721.sol";

contract FactoryERC721 {
    uint256 public collectionCount;
    mapping(uint256 => BCU23Collection) public collections;

    event CollectionCreated(address owner, uint256 id, address collection);

    function createCollection(
        // address owner,
        string memory contractUri,
        string[] memory uris
    ) public returns (BCU23Collection) {
        uint256 id = ++collectionCount;
        address owner = msg.sender;

        BCU23Collection collection = new BCU23Collection(
            owner,
            contractUri,
            uris
        );
        collections[id] = collection;

        emit CollectionCreated(owner, id, address(collection));
        return collection;
    }

    function getCollection(uint256 id) public view returns (BCU23Collection) {
        return collections[id];
    }
}
