pragma solidity 0.5.12;

contract Ownable{
    address owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner);require(msg.sender == owner,"Sender must be the owner.");
        _; //continue execution
    }
}