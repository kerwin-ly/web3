// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    mapping(address => uint256) public fundersAmount;
    uint256 MINIMUM_AMOUNT = 1 * 10 ** 18; // unit: wei / eth
    AggregatorV3Interface internal dataFeed;

    constructor() {
        dataFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306); // sepolia test network ETH/USD addr: https://docs.chain.link/data-feeds/price-feeds/addresses?page=1&testnetPage=1&testnetSearch=eth
    }

    function fund() external payable {
        require(convertEthToUsd(msg.value) >= MINIMUM_AMOUNT, "Need more ETH!");
        fundersAmount[msg.sender] = msg.value;
    }

    /**
     * Returns the latest answer.
     */
    function getChainlinkDataFeedLatestAnswer() public view returns (int256) {
        // prettier-ignore
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    function convertEthToUsd(uint256 amount) internal view returns (uint256) {
        uint256 ethPrice = uint256(getChainlinkDataFeedLatestAnswer()); // get ETH/USD exchange rate, value is 8 decimal places

        return amount * (ethPrice / 10 ** 8);
    }
}
