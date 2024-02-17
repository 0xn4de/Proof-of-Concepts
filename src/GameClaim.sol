pragma solidity ^0.8.0;

interface IGame {
    function claim() external payable;
    function writeChunks(ChunkWriteDto[] calldata input) external payable;
    function writeChunksPrice(ChunkWriteDto[] calldata input) external payable returns (uint256);
}
interface IUniswapV2Router02 {
    function swapETHForExactTokens(uint256,address[] calldata,address,uint256) external payable returns (uint[] memory);
}
struct ChunkWriteDto {
    uint8 x;
    uint8 y;
    uint256 data;
}
contract GameClaim {
    IGame game = IGame(0x52d69c67536f55EfEfe02941868e5e762538dBD6);
    constructor() payable {
        
        ChunkWriteDto[] memory pixels = new ChunkWriteDto[](576);
        uint256 currentIndex = 0;
        for (uint8 i = 0; i < 24; i++) {
            for (uint8 j = 0; j < 24; j++) {
                pixels[currentIndex] = ChunkWriteDto(i, j, 0);
                currentIndex++;
            }
        }
        uint256 cost = game.writeChunksPrice(pixels);
        address[] memory path = new address[](2);
        path[0] = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        path[1] = 0xdFa1A58780ef2208Cb55A1a77EcEE05E7a295397;
        IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D).swapETHForExactTokens{value:address(this).balance}(cost, path, address(this), block.timestamp);
        (bool success, ) = 0xdFa1A58780ef2208Cb55A1a77EcEE05E7a295397.call(abi.encodeWithSelector(bytes4(keccak256("approve(address,uint256)")), address(game), cost));
        require(success);
        game.writeChunks(pixels);
        game.claim();
        (bool success2, ) = msg.sender.call{value:address(this).balance}("");
        require(success2);
    }
    receive() external payable {}
}
