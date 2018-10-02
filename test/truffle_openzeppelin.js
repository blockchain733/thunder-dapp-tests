const HDWalletProvider = require('truffle-hdwallet-provider')
const dotenv = require('dotenv')

dotenv.config()

module.exports = {
  solc: { 
     optimizer: { 
	enabled: true, 
	runs: 200 
     } 
  },
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
      //provider: () => new HDWalletProvider(mnemonic, "http://qa01-testnet-rpc.tt-eng.com:8545",0,10),
      provider: () => new HDWalletProvider(process.env.MNEMONIC, process.env.THUNDER_RPC,0,10),
      network_id: "*", 
    //  gas: 4700000,   // <--- Twice as much
      //gas: 470000000,
      gas: 4700000,
      gasPrice: 1      
    },
    thunder_qafullnode: {
      provider: () => new HDWalletProvider(process.env.MNEMONIC, "http://10.3.3.114:8545", 0, 10),
      network_id: "*",
      gas:490000000,
      gasPrice:2000000000 
    }
  }
};
