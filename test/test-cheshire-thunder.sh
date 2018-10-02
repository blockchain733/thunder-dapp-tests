#!/bin/bash
EXPECT_PASS=6
EXPECT_FAIL=0
if [ "$1" == "-h" ]; then
   echo "Run this cheshire test with:
./test-cheshire-thundercore.sh
   A .env file must be present and contain 2 lines:

      THUNDER_RPC=http://....:8545
      MNEMONIC=12 word bip39 mnemonic...
"
      exit 1
fi
if [ -f ".env" ]; then
   if [ `grep -c "THUNDER_RPC" .env` == 0 ] ||
   [ `grep -c "MNEMONIC" .env` == 0 ]; then
      echo ".env file is incomplete!"
      exit 1
   fi
else
   echo "No .env detected!"
   exit 1
fi
stop_existing()
{
  `pkill -f yarn.js`
  `pkill -f server.js`
}
echo "--------Stopping any existing processes---------------------"
#`pkill -f yarn.js`
#`pkill -f server.js`
stop_existing
echo "--------Starting cheshire server and running tests----------"
echo "Server Results will be saved to cheshire-start.log"
. ./start-cheshire.sh &
echo "Test Results will be saved to cheshire-test.log"
sleep 10
PASSING=`grep -c "PASS" cheshire-test.log`
FAILING=`grep -c "FAIL" cheshire-test.log`
eval "cat cheshire-test.log"
if [[ $PASSING != $EXPECT_PASS ]] || [[ $FAILING != $EXPECT_FAIL ]]; then
   echo "ERROR Expect: $EXPECT_PASS passed and $EXPECT_FAIL failed"
   echo "      Actual: $PASSING passed and $FAILING failed"
   exit 1
fi
echo "--------------------Initiating API Call---------------------
Checking status of http://localhost:4000/kitties/1
Saving response to cheshire-api.log"
for i in $(seq 1 30)
do
   sleep 1;
   if (( i % 5 == 0 )); then
      echo "$i seconds elapsed"
   fi
   `curl -s http://localhost:4000/kitties/1 > cheshire-api.log`
   if [[ `grep -c "Genesis" cheshire-api.log` -gt 0 ]]; then
      echo "API call succeededed after $i seconds: $response"
      echo "----------------ALL CHESHIRE TESTS PASS---------------------"
      stop_existing
      exit 0
   fi
done
echo "API call failed. Could not contact server after 30 seconds."
stop_existing
exit 1
