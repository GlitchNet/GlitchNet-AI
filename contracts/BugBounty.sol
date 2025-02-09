// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract GlitchInsurance {
    AggregatorV3Interface internal bugOracle;
    
    struct Policy {
        uint256 coverageAmount;
        uint256 premiumPaid;
        uint256 expiration;
    }
    
    mapping(address => Policy) public policies;
    mapping(bytes32 => bool) public verifiedBugs;
    
    event PolicyIssued(address indexed holder, uint256 coverage);
    event ClaimPaid(address indexed claimant, uint256 amount);

    constructor(address oracleAddress) {
        bugOracle = AggregatorV3Interface(oracleAddress);
    }

    function purchaseCoverage(uint256 duration) external payable {
        uint256 coverage = _calculateCoverage(msg.value, duration);
        policies[msg.sender] = Policy({
            coverageAmount: coverage,
            premiumPaid: msg.value,
            expiration: block.timestamp + duration
        });
        emit PolicyIssued(msg.sender, coverage);
    }

    function fileClaim(bytes32 bugHash) external {
        require(verifiedBugs[bugHash], "Unrecognized vulnerability");
        Policy storage policy = policies[msg.sender];
        require(block.timestamp <= policy.expiration, "Policy expired");
        
        uint256 payout = policy.coverageAmount;
        payable(msg.sender).transfer(payout);
        emit ClaimPaid(msg.sender, payout);
    }

    function _calculateCoverage(uint256 premium, uint256 duration) internal view returns (uint256) {
        (, int256 riskFactor,,,) = bugOracle.latestRoundData();
        return (premium * uint256(riskFactor)) / (duration / 1 days);
    }
}
