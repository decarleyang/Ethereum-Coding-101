pragma solidity 0.5.12;

contract personInfo{
    struct person{
        string name;
        uint age;
        bool isSenior;
        uint balance;
    }
    
    event personCreated(string name,bool isSenior);
    
    event personDeleted(string name,address owner);
    
    address owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner);require(msg.sender == owner,"Sender must be the owner.");
        _; //continue execution
    }

    modifier costs(uint cost){
        require(msg.value >= cost);
        _;
    }
    mapping(address => person) private people;
    address[]private creators;
    
    function createPeson(string memory name, uint age) public payable costs(1 ether){
        address creator = msg.sender;
        
        require(age <= 150, "Age need to below 150.");
        
        person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.balance += msg.value;
        if(age >= 65){
            newPerson.isSenior = true;
        }
        else{
            newPerson.isSenior = false;
        }
        people[creator] = newPerson;
        
        creators.push(msg.sender);
        assert(
            keccak256(
                abi.encodePacked(
                    people[msg.sender].name,
                    people[msg.sender].age,
                    people[msg.sender].isSenior
                                )
                        )
            ==
            keccak256(
                        abi.encodePacked(
                            newPerson.name,
                            newPerson.age,
                            newPerson.isSenior
                                )
                        )
                    );
                   
         emit personCreated(newPerson.name,newPerson.isSenior);
    }
    
    
    function getPerson() public view returns(string memory name, uint age,bool isSenior,uint value){
        address creator = msg.sender;
        return(people[creator].name,people[creator].age,people[creator].isSenior,people[creator].balance);
    }
    
    function deletePerson(address creator) public onlyOwner{
        string memory name = people[creator].name;
        
        delete people[creator];
        emit personDeleted(name,msg.sender);
    }
    
    function getCreator(uint index) public view onlyOwner returns(address) {
        return creators[index];
    }
    
    function withdrawAll() public onlyOwner returns(uint){
        uint toTransfer = people[msg.sender].balance;
        people[msg.sender].balance = 0;
        msg.sender.transfer(toTransfer);
        return toTransfer;
    }
}