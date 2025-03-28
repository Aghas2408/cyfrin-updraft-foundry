// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH/USD rate in 18 digit
        return uint256(answer * 10000000000);
    }

    // 1000000000
    // call it get fiatConversionRate, since it assumes something about decimals
    // It wouldn't work for every aggregator
    function getConversionRate(
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // the actual ETH/USD conversation rate, after adjusting the extra 0s.
        return ethAmountInUsd;
    }
}

// foundryup  for updating the foundry
// forge init for creating empty forge project
// forge build for compiling the the contracts
// forge create Counter --interactive --broadcast for deploying contract (broadcast for executing transaction)
// forge script script/Counter.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key 0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6    for executing script on specific chain with specific address
// cast --to-base 0x32e26 dec   for converting for hexidecimal to decimal
// cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "increment()" --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80  for sending the transaction
// cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "number()" --rpc-url $RPC_URL --private-key $PRIVATE_KEY    for calling the blockchain like view or pure functions
// forge script script/Counter.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast  for deploying contract to Sepolia
// forge install smartcontractkit/chainlink-brownie-contracts@1.1.1 for installing specific version
// forge test for running tests after compiling
// forge install smartcontractkit/chainlink-brownie-contracts for installing the package
// forge install smartcontractkit/chainlink-brownie-contracts@1.1.1  for installing the specific version
// forge test -vv for logs
// forge test --match-test testPriceFeedVersionAccurate -vv --fork-url $SEPOLIA_RPC_URL  for running specific test on specific fork chain
// forge coverage to see how many % of lines are tested
// forge test default address 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38
