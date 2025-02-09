// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library BugTemplates {
    enum BugType { 
        EMOJI_BALANCE, 
        NEGATIVE_REWARDS,
        RECURSIVE_REVERT,
        TIMELOCK_CHAOS
    }

    struct BugRegistry {
        BugType activeBug;
        mapping(BugType => string) bugNames;
    }

    function applyRandomBug(BugRegistry storage registry, uint256 seed) internal {
        uint256 bugCount = uint256(type(BugType).max) + 1;
        registry.activeBug = BugType(seed % bugCount);
        
        // Initialize bug names
        registry.bugNames[BugType.EMOJI_BALANCE] = "Emoji Balance";
        registry.bugNames[BugType.NEGATIVE_REWARDS] = "Negative Rewards";
        registry.bugNames[BugType.RECURSIVE_REVERT] = "Recursive Revert";
        registry.bugNames[BugType.TIMELOCK_CHAOS] = "Timelock Chaos";
    }

    function getCurrentBugName(BugRegistry storage registry) internal view returns (string memory) {
        return registry.bugNames[registry.activeBug];
    }
}
