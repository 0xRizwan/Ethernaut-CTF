// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}



contract Force{
    constructor() payable{

    }

    function destruct(address forceAddress) public {
        selfdestruct(payable(forceAddress));
    }
}


// Vulnerability
// The contract does not have fallback OR receive OR payable function to receive ethers. 

// Recommended Mitigation steps
// To receive ether in contract, it should have receive or fallback or payable function . 