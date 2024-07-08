// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { Test, console } from 'forge-std/Test.sol';
import { DeployMoodNFT } from 'script/DeployMoodNFT.s.sol';
import { CodeConstants } from 'script/HelperConfig.s.sol';

contract DeployMoodNFTTest is Test, CodeConstants {
    DeployMoodNFT deployer;

    function setUp() public {
        deployer = new DeployMoodNFT();
    }

    function testSVGToImageURI() public view {
        string memory expectedURI = HAPPY_SVG_URI;
        string memory svg = vm.readFile('./img/happy.svg');
        string memory actualURI = deployer.svgToImageURI(svg);
        assert(keccak256(abi.encodePacked(actualURI)) == keccak256(abi.encodePacked(expectedURI)));
    }
}
