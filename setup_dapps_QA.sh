#Prereqs
npm install truffle-hdwallet-provider
npm install -g truffle
cp test/tests.list .
cp test/test_dapps.py .
#Prepare Cryptokitties cheshire
echo "Setting up Cryptokitties cheshire for testing"
npm i -g truffle
mkdir cryptokitties
(cd cryptokitties;git clone https://github.com/thundercore/cheshire.git;cd cheshire;curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -;echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list;sudo apt-get update && sudo apt-get install yarn;yarn install)
cp test/start-cheshire.sh cryptokitties/cheshire/
cp test/test-cheshire-thunder.sh cryptokitties/cheshire/
#Prepare MyToken
echo "Setting up MyToken for testing"
mkdir MyToken
(cd MyToken;truffle unbox thundercore/dapp-tutorial;npm install ethereumjs-abi;npm install dotenv;mkdir test)
cp test/TestMyToken.js MyToken/test/
cp test/truffle_MyToken.js MyToken/truffle.js
#Prepare openzeppelin
echo "Setting up openzeppelin"
git clone https://github.com/OpenZeppelin/openzeppelin-solidity.git
cp test/truffle_openzeppelin.js openzeppelin-solidity/truffle.js
cp test/test_thunder.py openzeppelin-solidity/
chmod 777 openzeppelin-solidity/test_thunder.py
cp test/openzeppelin_tests.txt openzeppelin-solidity/
npm install dotenv
(cd openzeppelin-solidity;git checkout 6dab312;npm install --save-dev chai;npm install --save-dev chai-bignumber)
#Prepare augure-core
echo "Setting up augure-core"
git clone https://github.com/AugurProject/augur-core.git
(cd augur-core;git checkout 04e981f4;npm install npx;npm install;pip install -r requirements.txt;pip install docker-compose;)
cp test/docker-compose-geth.yml augur-core/source/support/test/integration/
#Final messages
echo "Setup complete, you must still:
- For cryptokitties/cheshire: populate the config.json file with your account information. (MAKE SURE THE ACCOUNTS USE ONLY lowercase letters)
- create a .env file in the main dapps folder containing 
       THUNDER_RPC=http://....:8545
       MNEMONIC=12 word bip39 mnemonic...
- For openzeppelin, create 5 accounts from the seed that have funds

Once the correct information/configuration is present, run with:
Example: python3 test_dapps.py tests.list thunder
"
