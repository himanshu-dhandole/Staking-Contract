// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;


contract StakingContract {

    mapping (address => uint) stakes ;
    uint totalStake ;

    constructor(){

    }
    function stake() payable public {
        require(msg.value >= 0 , "the amt cannot be 0");
        stakes[msg.sender] += msg.value ;
        totalStake += msg.value ;
    }

    function unstake(uint _amount) payable public {
        require(stakes[msg.sender] >= _amount);
        payable(msg.sender).transfer(_amount) ;
        stakes[msg.sender] -= _amount ;
        totalStake -= _amount ;
    }
}