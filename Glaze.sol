// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Glaze is ERC20 {
    constructor(uint256 initialSupply) ERC20("Glaze", "GLZ") {
        _mint(msg.sender, initialSupply);
    }   
    function decimals() public view virtual override returns(uint8){
        return 1;
    }   
}