// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/BPContract.sol";


contract QuothToken is ERC20, Ownable {
  BPContract public BP;
  bool public BPEnabled;
  bool public BPDisabledForever = false;

  constructor(
    string memory name_,
    string memory symbol_,
    address recipient_,
    uint256 amount_
  ) ERC20(name_, symbol_) {
    require(amount_ > 0, "QuothToken: Amount is zero");
    _mint(recipient_, amount_);
  }

  function setBP(address _bp) external onlyOwner {
    require(address(BP) == address(0), "QuothToken: BP already set");
    BP = BPContract(_bp);
  }

  function toggleBP() external onlyOwner {
    BPEnabled = !BPEnabled;
  }

  function disableForeverBP() external onlyOwner {
    require(BPDisabledForever == false, "QuothToken BP already disabled forever");
    BPDisabledForever = true;
  }

  function _transfer(address sender, address recipient, uint256 amount) internal override(ERC20) {
    if (BPEnabled && !BPDisabledForever) BP.protect(sender, recipient, amount);
    super._transfer(sender, recipient, amount);
  }
}
