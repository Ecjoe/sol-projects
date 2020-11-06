pragma solidity >=0.5.13 < 0.7.3;

contract lotterysystem{
    
    address payable public owner;
    bool isPause;
    
    constructor() public{
        owner=msg.sender;
    }
    
    mapping(address => uint) public addressofparticipants;
    address[] addressofparticipant;
    
    function lotteryticketdistribution() payable public{
        require(msg.value>=1 ether,"min 1 ether to participate");
        require(contains(msg.sender)== 0,"already a participant");
        addressofparticipants[msg.sender]=msg.value; 
        addressofparticipant.push(msg.sender);
    }
    
    function contains(address _addr) private view returns(uint){
        return addressofparticipants[_addr];
    }
    
    function randomnumberfunction() private view onlyOwner returns(uint){
        uint randomnumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender,block.difficulty))) % addressofparticipant.length;
        return randomnumber;
    }
    
    function trasferEtherToWinner() public onlyOwner{
        uint randomwinner= randomnumberfunction();
        address payable winner=payable(addressofparticipant[randomwinner]);
        winner.transfer(address(this).balance);
    }
    
    function setpause()  public onlyOwner pausingcontract{
    }
    
    function close() public onlyOwner{
        selfdestruct(owner);
    }
    
    function reset() public onlyOwner{
        delete addressofparticipant;
    }
    modifier onlyOwner(){
        require(msg.sender==owner,"owner has access to this");
        _;
    }
    
    modifier pausingcontract(){
        require(!isPause,"not an owner");
        _;
    }
    
}
