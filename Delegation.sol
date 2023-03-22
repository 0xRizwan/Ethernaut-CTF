// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delegate {

  address public owner;

  constructor(address _owner) {
    owner = _owner;
  }

  function pwn() public {
    owner = msg.sender;
  }
}

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    (bool result,) = address(delegate).delegatecall(msg.data);
    if (result) {
      this;
    }
  }
}


// Vulnerability
// Delegate call is a risky function and has been used as an attack vector in past. Here It the delegateCall is giving 
// the access of all states of Delegate address states and function which can be modified easily.abi

// Recommended Mitigation steps
// The delegate call is the powerful feature but also the dangarous one but it can be used with extreme care. It is not 
// recommended to use delegateCall as it gives open access to contracts states. 