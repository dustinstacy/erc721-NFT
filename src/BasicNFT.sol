// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { ERC721 } from '@openzeppelin/contracts/token/ERC721/ERC721.sol';

contract BasicNFT is ERC721 {
    uint256 private tokenCounter;
    mapping(uint256 => string) private tokenIdToUri;

    constructor() ERC721('Golems', 'GOL') {
        tokenCounter = 0;
    }

    function mintNFT(string memory tokenUri) public {
        tokenIdToUri[tokenCounter] = tokenUri;
        _safeMint(msg.sender, tokenCounter);
        tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // return 'ipfs://QmZBWXvTxruyW8qCKgiWLkPzyeGhKiYSayYmt7MvNtmuDr';
        return tokenIdToUri[tokenId];
    }
}
