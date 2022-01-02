// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/kashi/IResolver.sol";

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
            if(rate != lastExchangeRate) {
                canExec = true;
                execPayload = abi.encodeWithSignature("updateExchangeRate()");
            }
        }
    }

}
