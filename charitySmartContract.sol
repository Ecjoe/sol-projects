pragma solidity >=0.5.13 < 0.7.3;

contract charity_smart_contract{
    
    address public owner;
    uint public my_balance;
    bool public isPause;
    
    struct paymentdetails{
        address donor;
        uint amount;
    }
    
    constructor() public{
        owner=msg.sender;
    }
    
    function receiveEthers() public payable{
        my_balance += msg.value;
        
    }
    
    function transferEthers(address payable _needy) public payable ownerAllowed{
        _needy.transfer(address(this).balance);   
    }
    
    function setpause(bool _isPause)  public ownerAllowed ownerpause{
        isPause=_isPause;
    }
    
    function setOwner(address _newOwner) public ownerAllowed {
        require(isPause==true,"not paused");
        owner=_newOwner;
        
    }
    modifier ownerAllowed(){
        require(msg.sender== owner,"owner has access to this");
        _;
    }
    modifier ownerpause(){
        require(!isPause,"owner has access to this ssaa");
        _;
    }
}

