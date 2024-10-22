// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// xiaokee means wealth and salary in ancient dinosour language.
contract XiokeeToken is ERC20 {

    uint256 private constant INITIAL_SUPPLY = 100000 * (10**18);
    address public taxCollector;
    uint256 public taxRate = 3;

    constructor(address _taxCollector) ERC20("Xiaokee Token", "XKEE") {
        _mint(msg.sender, INITIAL_SUPPLY);
        taxCollector = _taxCollector;
    }

    function setTaxRate(uint256 _taxRate) public {
        // TODO: validate taxrate cannot be higher than 15
        taxRate = _taxRate;
    }

    function paySalary(address employeeAddress, uint256 salaryAmount) public  {
        uint256 taxAmount = (salaryAmount * taxRate) / 100;
        uint256 netSalary = salaryAmount - taxAmount;

        _transfer(msg.sender, employeeAddress, netSalary);
        _transfer(msg.sender, taxCollector, taxAmount);
    }


}

