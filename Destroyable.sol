import "./Ownable.sol";
pragma solidity 0.5.12;

contract Destroyable is Ownable{
    function close() public onlyOwner { //onlyOwner is custom modifier
        selfdestruct(msg.sender);  // `owner` is the owners address
    }
}