pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {GameClaim} from "../src/GameClaim.sol";


contract GameClaimTest is Test {
    GameClaim exploit;
    address bob;
    function setUp() public {
        vm.createSelectFork(vm.rpcUrl('mainnet'), 19223114);
        bob = makeAddr("bob");
        vm.deal(bob, 1 ether);

    }
    function test_Claim() public {
        vm.prank(bob);
        console2.log("ETH balance before: ", bob.balance);
        vm.warp(block.timestamp + 100);
        exploit = new GameClaim{value: 0.1 ether}();
        console2.log("ETH balance after: ", bob.balance);
    }
}