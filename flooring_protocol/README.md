# Flooring Protocol PoC

Info on hack: https://twitter.com/0xfoobar/status/1736190355257627064

## Cause
Recently changed implementation had an unsafe external multicall function allowing anyone to execute a call from 0x49AD262C49C7aA708Cc2DF262eD53B64A17Dd5EE, including a `transferFrom` to NFT contracts

Funds at risk from approvals included around 30 Azukis, 17 BAYCs, 200 DeGods and more

## Fix
Implementation changed to remove unsafe function
## Exploit
- Call extMulticall on 0x49AD262C49C7aA708Cc2DF262eD53B64A17Dd5EE, with array of CallData structs (NFTContract, transferFrom(victim, exploiter, tokenId))
## Testing
Add an Ethereum RPC URL to .env
```shell
forge build
```

```shell
forge test -vv
```

S/O to [0xQuit](https://twitter.com/0xQuit) for [inspiration](https://github.com/QuitCrypto/NFTTraderExploit)
