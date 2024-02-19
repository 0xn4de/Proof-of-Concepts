# Game Contract PoC

Info on hack: https://twitter.com/AnciliaInc/status/1757533144033739116

## Cause
_(copied from [Ancilia](https://twitter.com/AnciliaInc/status/1757534105359753575))_

There is a logic error in the newBidEtherMin() function allowing the bid user to submit only >5% of the last bid amount and bypass the check. Since then the full amount of the last bid amount will be returned back to the last bidAddress which could be any.
The function  _sendEther will send back ETH to the last bidAddress. The problem is that the contract uses "call" to send the ETH which allows the re-entrancy attack.
[Example](https://etherscan.io/tx/0xe07fa7cf5f590ea82cf195923549722f924857537111aeb3824359d3e1c2e32f)
## Cause for Exploit 2
The contract was meant to give out its ETH balance after the auction for its NFT had finished. Due to a missing check, the auction was going on at the same time as the main game. Because of this, once the auction ended, the ETH was claimable by claiming all 576 pixels. This operation is very expensive gas-wise.

[Example](https://etherscan.io/tx/0x58caa5c325c17a276b237a0915b43b59a5301da98c336a7e786089c4aaf8e39e)

## Cause for Exploit 3
The contract sends back the ETH after each bid, which allows the receiver to have its fallback function called (in the case of a contract). An alternative could be a separate refund function that checks how much ETH to withdraw, instead of doing it in the same transaction as the bid tx
## Fix
None
## Exploit
- GameReentrancy.sol
- Create a contract to make a bid of 0.1 ETH on the contract
- Then make a bid of 0.005 ETH (newBidEtherMin is 1/20 current bid)
- 0.1 ETH gets sent to contract, use the receive function to create re-entrancy on the Game contract by making a constant bid for 0.005 ETH (bidEther on the contract stays the same, 0.1 ETH) until contract is empty

## Exploit 2
- GameClaim.sol
- Contract checks the cost of 576 pixel claims
- Contract buys the required PXL from Uniswap
- Claims the 576 pixels, then calls claim() and gets all the ETH in the contract
## Exploit 3
- GameDoS.sol
- Contract calls makeBid() with the minimum bid
- Future bids all try to refund the bid ETH, but the fallback in GameDoS reverts
## Testing
Add an Ethereum RPC URL to .env
```shell
forge test
```