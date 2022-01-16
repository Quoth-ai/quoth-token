// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract QuothToken is ERC20 {
  constructor(
    string memory name_,
    string memory symbol_,
    address recipient_,
    uint256 amount_
  ) ERC20(name_, symbol_) {
    require(amount_ > 0, "QuothToken: Amount is zero");
    _mint(recipient_, amount_);
  }
}
