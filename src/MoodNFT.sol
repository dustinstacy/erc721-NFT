// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { ERC721 } from '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import { Base64 } from '@openzeppelin/contracts/utils/Base64.sol';

contract MoodNFT is ERC721 {
    error MoodNFT__CantFlipMoodIfNotOwner();

    uint256 private tokenCounter;
    string private sadSVGURI;
    string private happySVGURI;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 tokenId => Mood) private tokenIdToMood;

    constructor(string memory _sadSVGURI, string memory _happySVGURI) ERC721('Mood', 'MD') {
        tokenCounter = 0;
        sadSVGURI = _sadSVGURI;
        happySVGURI = _happySVGURI;
    }

    function mintNFT() public {
        tokenIdToMood[tokenCounter] = Mood.HAPPY;
        _safeMint(msg.sender, tokenCounter);
        tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert MoodNFT__CantFlipMoodIfNotOwner();
        }
        if (tokenIdToMood[tokenId] == Mood.HAPPY) {
            tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            tokenIdToMood[tokenId] == Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return 'data:application/json;base64,';
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI = happySVGURI;

        if (tokenIdToMood[tokenId] == Mood.SAD) {
            imageURI = sadSVGURI;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '", "description": "An NFT that reflects the owners mood.", "attributes": [{"trait_type": "moodiness", "value": 100}], "image": "',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
