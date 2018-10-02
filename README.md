# thunder-dapp-tests
Make setup_dapps_QA.sh executable, then run it  
Once the setup is complete, create a .env file in the main project folder containing 4 lines:  
THUNDER_RPC=http://{url}:{port}  
MNEMONIC={12 word bip39 mnemonic}  
ETHEREUM_HTTP=http://{url}:{port}  
ETHEREUM_PRIVATE_KEY={This should be the Private Key of the 12-word mnemonic above.   
			You can derive it here: https://iancoleman.io/bip39/}

For cheshire, populate the config.json file and make sure the first account contains ONLY lowercase   
letters. These Address and Private Key pairs may also be derived from the mnemonic at:  
         https://iancoleman.io/bip39/ (Make sure to select Coin: ETH-Ethereum)
