var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic = "scheme inherit misery rain truly borrow taste cereal give capable toward bullet";

module.exports = {
  networks: {
    development: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "http://127.0.0.1:8545/", 0, 50); 
        // 50 - number of accounts, must be greater than TEST_ORACLE_COUNT
        // Repreents the 'accounts' param in ExerciseC6D.js
        // run ganache-cli -a 50 if runnning into the error 'Error: sender doesn't have enough funds to send tx. The upfront cost is: 1999999900000000000 and the sender's account only has: 0'
      },
      network_id: '*',
      gas: 9999999 // run ganache-cli -l 9999999 if running into error 'Exceeds block gas limit'
    }
  },
  compilers: {
    solc: {
      version: "^0.4.25"
    }
  }
};