// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20} from  "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import{ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
contract ReverToken is ERC20,ERC20Burnable {
    constructor(uint256 initialSupply) ERC20("Rever", "RVR") {
        _mint(msg.sender, initialSupply);
    }
}
