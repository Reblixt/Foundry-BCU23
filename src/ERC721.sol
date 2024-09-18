// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BCU23Collection is ERC721, ERC721URIStorage, ERC721Pausable, Ownable {
    uint256 private _nextTokenId = 1;

    string public contractMetadata;

    event ContractURIUpdated();

    constructor(
        address initialOwner,
        string memory contractUri,
        string[] memory uris
    ) ERC721("BCU23Collection", "BCU") Ownable(initialOwner) {
        contractMetadata = contractUri;
        if (uris.length != 0) {
            for (uint256 i = 0; i < uris.length; i++) {
                _constructMint(initialOwner, uris[i]);
            }
        }
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function contractURI() public view returns (string memory) {
        return string.concat("data:application/json;utf8,", contractMetadata);
    }

    function updateContractURI(string memory data) external onlyOwner {
        contractMetadata = data;
        emit ContractURIUpdated();
    }

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override(ERC721, ERC721Pausable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _constructMint(address to, string memory uri) internal {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }
}
