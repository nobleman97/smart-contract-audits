// require("@nomicfoundation/hardhat-toolbox");

// /** @type import('hardhat/config').HardhatUserConfig */
// module.exports = {
//   solidity: ">=0.8.0",
// };

// require("@nomiclabs/hardhat-waffle");
require('@nomiclabs/hardhat-ethers');
require("@nomiclabs/hardhat-etherscan")
const { mnemonic, privateKey, bscScanApiKey, etherScanApiKey, infuraProjectId } = require('./secrets.json');

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

//For extra HELP on how to add other networks... 
//Go here: https://github.com/mingderwang/bsc-hardhat-template/blob/main/hardhat.config.js

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  //solidity: "0.8.4",
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: etherScanApiKey //necessary for verification
  },
  defaultNetwork: "bsctestnet",
  networks: {
   
    bsctestnet: {
      url: "https://data-seed-prebsc-2-s1.binance.org:8545",
      chainId: 97,
      accounts: [privateKey]
    },

    rinkeby: {
      url: "https://rinkeby.infura.io/v3/" + infuraProjectId,
      chainId: 4,
      gasPrice: 20000000000,
      accounts: [privateKey]
    },

    // ropsten: {
    //   url: "https://ropsten.infura.io/v3/" + infuraProjectId,
    //   chainId: 3,
    //   //gasPrice: 20000000000,
    //   // accounts: {mnemonic: mnemonic}
    //   accounts: [privateKey]
    // }

  },
    
solidity: {
  compilers: [
    {
      version: "0.8.9",
      settings: {
        optimizer: {
          runs:200,
          enabled: true
        }
      } 
    },
    {
      version: "0.6.2"
    },
    {
      version: "0.5.0"
    }
  ],

},
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 20000
  }
};

