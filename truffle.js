var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic = "clever twice seed rural liquid unique reopen laundry best earn know segment";

module.exports = {
  networks: {
    development: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "http://127.0.0.1:8545/", 0, 10);
      },
      network_id: '*',
      gas: 9999999
    }
  },
  compilers: {
    solc: {
      version: "^0.4.25"
    }
  }
};