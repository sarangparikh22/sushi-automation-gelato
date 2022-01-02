// SPDX-License-Identifier: MIT

pragma solidity 0.8.11;

import "./IKashiPair.sol";

interface IResolver {
    function checker(IKashiPair kashiPair)
        external
        view
        returns (bool canExec, bytes memory execPayload);
}
