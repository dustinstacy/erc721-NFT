// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { Test } from 'forge-std/Test.sol';
import { DeployBasicNFT } from 'script/DeployBasicNFT.s.sol';
import { BasicNFT } from 'src/BasicNFT.sol';

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;
    address public USER = makeAddr('user');
    string public constant GOLEM = 'ipfs://QmZBWXvTxruyW8qCKgiWLkPzyeGhKiYSayYmt7MvNtmuDr';

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    function testBasicNFTSetsTheNameProperly() public view {
        string memory expectedName = 'Golems';
        string memory actualName = basicNFT.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNFT.mintNFT(GOLEM);

        assert(basicNFT.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(GOLEM)) == keccak256(abi.encodePacked(basicNFT.tokenURI(0))));
    }
}
