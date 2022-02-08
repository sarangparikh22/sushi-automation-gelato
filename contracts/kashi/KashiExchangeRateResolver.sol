// SPDX-License-Identifier: MIT

pragma solidity 0.8.11;

import "../interfaces/kashi/IResolver.sol";

contract KashiExchangeRateResolver is IResolver {
    function checker(IKashiPair kashiPair)
        external
        view
        override
        returns (bool canExec, bytes memory execPayload)
    {
        IOracle oracle = kashiPair.oracle();
        bytes memory oracleData = kashiPair.oracleData();
        uint256 lastExchangeRate = kashiPair.exchangeRate();
        (bool updated, uint256 rate) = oracle.peek(oracleData);
        if (updated) {
            uint256 deviation = ((
                lastExchangeRate > rate
                    ? lastExchangeRate - rate
                    : rate - lastExchangeRate
            ) * 100) / lastExchangeRate;
            if (deviation > 20) {
                canExec = true;
                execPayload = abi.encodeWithSignature("updateExchangeRate()");
            }
        }
    }
}
