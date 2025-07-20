// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

contract StakingContract {
    mapping (address => uint) stakes ;
    uint totalStake ;
    address implementation ;

    constructor(address _implementation){
        implementation = _implementation ;
    }

    fallback() external {
       (bool success ,) =  implementation.delegatecall(msg.data);
       require(success , "Delegate call failed");
    }
}