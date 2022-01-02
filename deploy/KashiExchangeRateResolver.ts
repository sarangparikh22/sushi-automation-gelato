import { DeployFunction } from "hardhat-deploy/dist/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";

const func: DeployFunction = async function ({
  getNamedAccounts,
  deployments,
  run
}: HardhatRuntimeEnvironment) {
  const { deploy } = deployments;

  const { deployer } = await getNamedAccounts();

  const { address } = await deploy("KashiExchangeRateResolver", {
    from: deployer,
    args: [],
  });

  console.log(`KashiExchangeRateResolver deployed to ${address}`);

  await run("verify:verify", {
    address: address,
    constructorArguments: [],
  });

};

export default func;
