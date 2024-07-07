// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { ERC721 } from '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import { Base64 } from '@openzeppelin/contracts/utils/Base64.sol';

contract MoodNFT is ERC721 {
    uint256 private tokenCounter;
    string private sadSVGImageURI;
    string private happySVGImageURI;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 tokenId => Mood) private tokenIdToMood;

    constructor(string memory _sadSVGImageURI, string memory _happySVGImageURI) ERC721('Mood', 'MD') {
        tokenCounter = 0;
        sadSVGImageURI = _sadSVGImageURI;
        happySVGImageURI = _happySVGImageURI;
    }

    function mintNFT() public {
        _safeMint(msg.sender, tokenCounter);
        tokenIdToMood[tokenCounter] = Mood.HAPPY;
        tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return 'data:application/json;base64,';
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;
        if (tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = happySVGImageURI;
        } else {
            imageURI = sadSVGImageURI;
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
                                '", "description": "An NFT that reflects the owners mood.", "attributes": [{"trait_type": "moodiness", "value": 100}]"image": "',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
