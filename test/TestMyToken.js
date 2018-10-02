var assert = require('assert');
var MyToken = artifacts.require('MyToken')
const HDWalletProvider = require('truffle-hdwallet-provider')

contract('MyToken', function(accounts){
   it("should put 1000000 tokens in the Account 1", function() {
      return MyToken.deployed().then(async function(instance) {
	 return instance.balanceOf(accounts[0]);
      }).then(function(balance) {
	 assert.equal(balance.valueOf(), 1000000, "Initial balance in account 1 was not correct (expected 1000000), found " + balance.valueOf());
         });
   });
   it("should transfer 88 tokens to Account 2", async function () {
      return MyToken.deployed().then(async function(instance) {
	 await instance.transfer(accounts[1], 88);
	 return instance.balanceOf(accounts[1]);
      }).then(function(balance) {
	 assert.equal(balance.valueOf(), 88, "88 could not be sent to second account. Account 2 has:" + balance.valueOf());
         });
      });
    it("should confirm 88 has been deducted from Account 1", function() {
      return MyToken.deployed().then(async function(instance) {
	 return await instance.balanceOf(accounts[0]);
      }).then(function(balance) {
	 assert.equal(balance.valueOf(), 1000000-88, "Account 1 did not send the funds, Account 1 has:" + balance.valueOf());
         });
    });
});
