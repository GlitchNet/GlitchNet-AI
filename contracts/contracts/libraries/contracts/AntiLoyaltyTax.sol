// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./libraries/ChaosMath.sol";

abstract contract AntiLoyaltyTax {
    using ChaosMath for uint256;
    
    struct TaxRecord {
        uint256 lastAction;
        uint256 penaltyAccumulated;
    }
    
    mapping(address => TaxRecord) public taxRecords;
    uint256 public constant TAX_THRESHOLD = 7 days;

    modifier applyTax(address account) {
        _applyPenalty(account);
        _;
    }

    function _applyPenalty(address account) internal {
        TaxRecord storage record = taxRecords[account];
        uint256 holdDuration = block.timestamp - record.lastAction;
        
        if(holdDuration > TAX_THRESHOLD) {
            uint256 penalty = _calculatePenalty(account, holdDuration);
            _transferTax(account, penalty);
            record.penaltyAccumulated += penalty;
        }
        
        record.lastAction = block.timestamp;
    }

    function _calculatePenalty(address account, uint256 duration) internal view virtual returns (uint256);
    function _transferTax(address account, uint256 amount) internal virtual;
}
