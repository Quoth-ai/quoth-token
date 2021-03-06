// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;


abstract contract BPContract {
  function protect(address sender, address receiver, uint256 amount) external virtual;
}
