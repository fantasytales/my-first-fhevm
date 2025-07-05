// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title A simple counter contract
contract Counter {
    uint32 private _count;

    /// @notice Custom error for underflow
    error Underflow();

    /// @notice Returns the current count
    function getCount() external view returns (uint32) {
        return _count;
    }

    /// @notice Increments the counter by a specific value
    function increment(uint32 value) external {
        _count += value;
    }

    /// @notice Decrements the counter by a specific value
    function decrement(uint32 value) external {
        if (_count < value) revert Underflow();
        _count -= value;
    }
}
