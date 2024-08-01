// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployReverToken} from '../script/DeployReverToken.s.sol';
import {Test,console}  from 'forge-std/Test.sol';
import {ReverToken} from '../src/ReverToken.sol';


contract ReverTokenTest is Test{
ReverToken  public reverToken;
DeployReverToken public deployer;
address bob = makeAddr('bob');
address ada = makeAddr('ada');
uint256 public constant STARTING_BALANCE = 2000 ether;
uint256 public constant INITIAL_SUPPLY = 10000 ether;

// testEvent

event Transfer(address indexed _sender, address indexed _reciever, uint256 _value);
event Approval(address indexed _sender, address indexed _reciever, uint256 _value);

function setUp() external{
      deployer = new DeployReverToken();
      reverToken = deployer.run();
      //vm.prank(msg.sender);
      hoax(msg.sender,STARTING_BALANCE);
      reverToken.transfer(bob,STARTING_BALANCE);
}


    function testTotalSupply() public {
        assertEq(reverToken.totalSupply(), INITIAL_SUPPLY);
    }
function testBobBalance() public {
    
    //console.log(ReverToken.balanceOf(bob));
    assert(STARTING_BALANCE == reverToken.balanceOf(bob));
}


function testAllowances () public{
    uint256 spending_amt = 700 ether;
    vm.prank(bob);
    reverToken.approve(ada,700 ether);

    vm.prank(ada);
    reverToken.transferFrom(bob,ada,spending_amt);
    
    assert(reverToken.balanceOf(ada) == spending_amt);
}

 function testTransferEvent() public {
        vm.expectEmit(true, true, false, true);
        emit Transfer(bob, ada, 500 ether);

        vm.prank(bob);
        reverToken.transfer(ada, 500 ether);
    }

     function testApprovalEvent() public {
        vm.expectEmit(true, true, false, true);
        emit Approval(bob, ada, 700 ether);

        vm.prank(bob);
        reverToken.approve(ada, 700 ether);
    }


    function testTransferFailure() public {
        vm.prank(bob);
        vm.expectRevert();
        reverToken.transfer(ada, STARTING_BALANCE + 5 ether);
    }

 function testAllowanceFailure() public {
        uint256 spending_amt = 700 ether;
        vm.prank(bob);
        reverToken.approve(ada, spending_amt);

        vm.prank(ada);
        vm.expectRevert();
        reverToken.transferFrom(bob, ada, spending_amt + 1 ether);
    }

    function testBurning() public {
        uint256 burn_amt = 500 ether;
        vm.prank(bob);
        reverToken.burn(burn_amt);
        assertEq(reverToken.balanceOf(bob), STARTING_BALANCE - burn_amt);
         assertEq(reverToken.totalSupply(), INITIAL_SUPPLY - burn_amt);
    }


}