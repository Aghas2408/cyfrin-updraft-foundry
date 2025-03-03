// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {
    FundMe public fundMe;
    uint256 number = 1;

    function setUp() public {
        // me -> FundMeTest -> FundMe the owner of FundMe is the test contract
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    function testDemo() public {
        console.log(number);
        assertEq(number, 1);
    }

    function testMinimumDollarIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        console.log(fundMe.i_owner());
        console.log(msg.sender);
        assertEq(fundMe.i_owner(), address(msg.sender));
    }

    function testPriceFeedVersionAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }
}
