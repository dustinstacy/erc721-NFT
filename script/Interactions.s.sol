// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { Script } from 'forge-std/Script.sol';
import { DevOpsTools } from 'lib/foundry-devops/src/DevOpsTools.sol';
import { BasicNFT } from 'src/BasicNFT.sol';
import { MoodNFT } from 'src/MoodNFT.sol';

contract MintBasicNFT is Script {
    string public constant GOLEM = 'ipfs://QmP4LGGc5qz4UbqCZ24JD9ZA4RxeVhQazDuNbjXBQPWQaZ';

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment('BasicNFT', block.chainid);
        mintNFTOnContract(mostRecentlyDeployed);
    }

    function mintNFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNFT(contractAddress).mintNFT(GOLEM);
        vm.stopBroadcast();
    }
}

contract MintMoodNFT is Script {
    function run() external {
        address mostRecentlyDeployedBasicNFT = DevOpsTools.get_most_recent_deployment('MoodNFT', block.chainid);
        mintNFTOnContract(mostRecentlyDeployedBasicNFT);
    }

    function mintNFTOnContract(address moodNFTAddress) public {
        vm.startBroadcast();
        MoodNFT(moodNFTAddress).mintNFT();
        vm.stopBroadcast();
    }
}

contract FlipMoodNFT is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentlyDeployedBasicNFT = DevOpsTools.get_most_recent_deployment('MoodNFT', block.chainid);
        flipMoodNFT(mostRecentlyDeployedBasicNFT);
    }

    function flipMoodNFT(address moodNFTAddress) public {
        vm.startBroadcast();
        MoodNFT(moodNFTAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}
