import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("BasicNFTModule", (m) => {
    const deployer = m.getAccount(0);

    const basicNFT = m.contract("BasicNFT", [], {
        from: deployer,
    })
    
    return { basicNFT };
});