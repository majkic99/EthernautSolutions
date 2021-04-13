pragma solidity ^0.6.0;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}

contract GibMoneyToForce{
    receive() external payable{
        
    }
    
    function gibMoney(address payable force) public{
        selfdestruct(force);
    }
}