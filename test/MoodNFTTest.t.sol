// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { Test, console } from 'forge-std/Test.sol';
import { MoodNFT } from 'src/MoodNFT.sol';
import { CodeConstants } from 'script/HelperConfig.s.sol';

contract MoodNFTTest is Test, CodeConstants {
    MoodNFT moodNFT;

    address USER = makeAddr('user');

    function setUp() public {
        moodNFT = new MoodNFT(SAD_SVG_URI, HAPPY_SVG_URI);
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        moodNFT.mintNFT();
        console.log(moodNFT.tokenURI(0));
    }
}
