# Game Contract PoC

Info on hack: https://twitter.com/AnciliaInc/status/1757533144033739116

## Cause
_(copied from [Ancilia](https://twitter.com/AnciliaInc/status/1757534105359753575))_
There is a logic error in the newBidEtherMin() function allowing the bid user to submit only >5% of the last bid amount and bypass the check. Since then the full amount of the last bid amount will be returned back to the last bidAddress which could be any.
The function  _sendEther will send back ETH to the last bidAddress. The problem is that the contract uses "call" to send the ETH which allows the re-entrancy attack.

## Fix
None
## Exploit
- Create a contract to make a bid of 0.1 ETH on the contract
- Then make a bid of 0.005 ETH (newBidEtherMin is 1/20 current bid)
- 0.1 ETH gets sent to contract, use the receive function to create re-entrancy on the Game contract by making a constant bid for 0.005 ETH (bidEther on the contract stays the same, 0.1 ETH) until contract is empty
## Testing
Add an Ethereum RPC URL to .env
```shell
forge test
```