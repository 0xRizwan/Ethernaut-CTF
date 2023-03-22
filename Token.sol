// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;

  constructor(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}


// Vulnerability
// since the contract is using the 0.6.0 solidity version so it causes underflow/overflow conditions. Here is overflow
// is happening

// Recommended Mitigation steps
// Always use solidity version ^0.8.0 to overcome underflow/overflow conditions, another alternative to use 0.6.0 version
// should be with openzeppelin safeMath library to perform the +/-/*/ / operations. 