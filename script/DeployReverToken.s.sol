//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


import {Script} from 'forge-std/Script.sol';
import {ReverToken} from '../src/ReverToken.sol';


contract DeployReverToken is Script{

      uint256 public constant TOTAL_TOKEN = 10000 ether;
function run() external returns(ReverToken ) {
     ReverToken reverToken;
     
      vm.startBroadcast();
       reverToken = new ReverToken(TOTAL_TOKEN);
      vm.stopBroadcast();
      return reverToken;
}

function totalSupply() public view returns(uint256){
      return TOTAL_TOKEN;
}
}