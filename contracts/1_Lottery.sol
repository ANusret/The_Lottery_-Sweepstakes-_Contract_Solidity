pragma solidity ^0.4.17;

contract Lottery {
    
    address public manager;
    address[] public players;

    constructor() public {
        manager = msg.sender;
    }

    modifier checkManager(){
        require(msg.sender == manager);
        _;
    }

    function enter() public payable{
        require( msg.value > .00001 ether );
        players.push(msg.sender);
    }

    function getPlayers() public view returns(address[]){
        return players;
    }

    function randomHelper() private view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty, now, players)));
    }

    function pickTheWinner() public payable checkManager{
        uint index = randomHelper() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0); 
    }

}
