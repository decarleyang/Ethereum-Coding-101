pragma solidity 0.5.12;

//interface
contract personInfo{
    function createPeson(string memory name, uint age) public payable;
}

contract externalContract{
    personInfo instance = personInfo(0x038F160aD632409BFB18582241d9Fd88C1A072Ba);
    
    function externalCreatePerson(string memory name, uint age) public payable{
        instance.createPeson.value(msg.value)(name,age);
    }
}