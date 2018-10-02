const HDWalletProvider = require('truffle-hdwallet-provider')
const dotenv = require('dotenv')

dotenv.config()

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*" // Match any network id
    },
    ganache: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },
    thunder: {
      provider: () => new HDWalletProvider(process.env.MNEMONIC, process.env.THUNDER_RPC,0,10),
      network_id: "*",
      //gas: 500000000,
      //gasPrice: 50000000000
      gas: 4500000,
      gasPrice: 1
    }
  }
};
