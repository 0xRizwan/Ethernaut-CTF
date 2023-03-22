
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
  bool public locked;
  bytes32 private password;

  constructor(bytes32 _password) {
    locked = true;
    password = _password;
  }

  function unlock(bytes32 _password) public {
    if (password == _password) {
      locked = false;
    }
  }
}


// Vulnerability
// Password should not be stored on blockchain even if there are private. Private variables can be read by using a library 
// function like web3.eth.getStorageAt(contract.address, slot number) and the hexa decimal or bytes can also be converted
// into strings by web3.utils.hexToAscii("...")

// Recommended Mitigation steps
// Passwords should never ever be stored on blockchain as it is public and transparent. 