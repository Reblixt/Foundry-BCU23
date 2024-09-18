// SPDX-License-Identifier: MIT

pragma solidity ^0.8.27;

import {ERC721Holder, IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Vault is ERC721Holder {
    address public contractAdmin;
    uint256 public vaultIdCounter;

    struct VaultData {
        uint256 vaultId;
        IERC721 nft;
        address owner;
        uint256[] tokenIds;
        uint256 deadline;
    }

    mapping(uint256 => VaultData) public vaults;

    error Vault__OnlyContractAdmin();
    error Vault__OnlyVaultOwner();
    error Vault__NoNftsWasProvided();
    error Vault__DeadlineNotReached();

    event VaultCreated(
        uint256 indexed vaultId,
        uint256[] indexed tokenIds,
        address indexed owner,
        address nft,
        uint256 deadline
    );

    modifier onlyContractAdmin() {
        require(msg.sender == contractAdmin, Vault__OnlyContractAdmin());
        // if (msg.sender != contractAdmin) revert Vault__OnlyContractAdmin();
        _;
    }

    modifier onlyVaultOwner(uint256 yourVaultId) {
        // if (vaults[yourVaultId].owner != msg.sender)
        //     revert Vault__OnlyVaultOwner();
        require(
            vaults[yourVaultId].owner == msg.sender,
            Vault__OnlyVaultOwner()
        );
        _;
    }

    constructor(address admin) {
        contractAdmin = admin;
    }

    function createVault(
        address nft,
        uint256[] memory nftIds,
        uint256 timeLocked
    ) external {
        // if (nftIds.length == 0) revert Vault__NoNftsWasProvided();
        require(nftIds.length > 0, Vault__NoNftsWasProvided());

        for (uint256 i = 0; i < nftIds.length; i++) {
            IERC721(nft).safeTransferFrom(msg.sender, address(this), nftIds[i]);
        }
        uint256 id = ++vaultIdCounter;
        vaults[id].vaultId = vaultIdCounter;
        vaults[id].owner = msg.sender;
        vaults[id].tokenIds = nftIds;
        vaults[id].nft = IERC721(nft);
        vaults[id].deadline = block.timestamp + timeLocked;

        emit VaultCreated(id, nftIds, msg.sender, nft, timeLocked);
    }

    function retrieveNFTs(
        uint256 yourVaultId,
        uint256[] memory tokenIds
    ) external onlyVaultOwner(yourVaultId) {
        uint256 vaultDeadline = vaults[yourVaultId].deadline;
        if (block.timestamp < vaultDeadline) revert Vault__DeadlineNotReached();

        for (uint256 i = 0; i < tokenIds.length; i++) {
            vaults[yourVaultId].nft.safeTransferFrom(
                address(this), // från Vault
                msg.sender, // till msg.sender
                tokenIds[i] // Vilka tokenIds
            );
        }
        delete vaults[vaultIdCounter];
    }

    function getVaultData(
        uint256 yourVaultId
    ) external view returns (VaultData memory) {
        return vaults[yourVaultId];
    }
}
