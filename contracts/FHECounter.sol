// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {FHE, euint32, externalEuint32} from "@fhevm/solidity/lib/FHE.sol";
import {SepoliaConfig} from "@fhevm/solidity/config/ZamaConfig.sol";

/// @title A simple fully homomorphic encrypted counter contract
contract FHECounter is SepoliaConfig {
    euint32 private _count;

    /// @notice Returns the current count
    function getCount() external view returns (euint32) {
        return _count;
    }

    /// @notice Increments the counter by a specific value
    function increment(externalEuint32 inputEuint32, bytes calldata inputProof) external {
        euint32 evalue = FHE.fromExternal(inputEuint32, inputProof);
        _count = FHE.add(_count, evalue);
        FHE.allowThis(_count);
        FHE.allow(_count, msg.sender);
    }

    /// @notice Decrements the counter by a specific value
    /// @dev Range checks should be handled off-chain because on-chain decryption is not supported.
    function decrement(externalEuint32 inputEuint32, bytes calldata inputProof) external {
        euint32 evalue = FHE.fromExternal(inputEuint32, inputProof);
        _count = FHE.sub(_count, evalue);
        FHE.allowThis(_count);
        FHE.allow(_count, msg.sender);
    }
}
