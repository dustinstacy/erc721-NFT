// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { Test, console } from 'forge-std/Test.sol';
import { MoodNFT } from 'src/MoodNFT.sol';
import { CodeConstants } from 'script/HelperConfig.s.sol';
import { DeployMoodNFT } from 'script/DeployMoodNFT.s.sol';

contract MoodNFTIntergrationTest is Test, CodeConstants {
    MoodNFT moodNFT;
    DeployMoodNFT deployer;

    address USER = makeAddr('user');

    function setUp() public {
        deployer = new DeployMoodNFT();
        moodNFT = deployer.run();
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        moodNFT.mintNFT();
        console.log(moodNFT.tokenURI(0));
    }

    function testFlipTokenToSad() public {
        vm.prank(USER);
        moodNFT.mintNFT();

        vm.prank(USER);
        moodNFT.flipMood(0);

        assert(keccak256(abi.encodePacked(moodNFT.tokenURI(0))) == keccak256(abi.encodePacked(SAD_SVG_URI)));
    }
}
