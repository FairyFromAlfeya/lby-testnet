#!/bin/bash
  
# turn on bash's job control
set -m
  
# Start the primary process and put it in the background
cuspd init --chain-id=local-testnet localvalidator
cuspd add-genesis-account libonomy1wudzuelv00gtcng7wnkrjtlpqq7jhprxj6a3zs 1000000000libocoin,1000000000propersixtoken
yes HcLM729H2a | cuspd gentx --name latoken
cuspd collect-gentxs
cuspcli config node http://127.0.0.1:26657
cuspcli config trust-node true
cuspcli config --chain-id=local-testnet

cuspd start &
  
# Start the helper process
cuspcli rest-server --chain-id=local-testnet --laddr=tcp://0.0.0.0:1317 --node tcp://localhost:26657
  
# the my_helper_process might need to know how to wait on the
# primary process to start before it does its work and returns
  
  
# now we bring the primary process back into the foreground
# and leave it there
fg %1