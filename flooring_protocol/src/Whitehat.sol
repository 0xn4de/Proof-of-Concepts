// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;
struct CallData {
    address target;
    bytes callData;
}
interface Periphery {
    function extMulticall(CallData[] calldata calls) external returns (bytes[] memory);
}
contract Whitehat {
    address public owner;
    Periphery FloorPeriphery = Periphery(0x49AD262C49C7aA708Cc2DF262eD53B64A17Dd5EE);
    constructor() {
        owner = msg.sender;
    }
    // can just call the proxy directly instead of this
    function start(CallData[] calldata calls) public {
        require(owner==msg.sender, "Not owner");
        FloorPeriphery.extMulticall(calls);
    }
}