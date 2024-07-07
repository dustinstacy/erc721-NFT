// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { Script } from 'forge-std/Script.sol';
import { DevOpsTools } from 'lib/foundry-devops/src/DevOpsTools.sol';
import { BasicNFT } from 'src/BasicNFT.sol';

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
