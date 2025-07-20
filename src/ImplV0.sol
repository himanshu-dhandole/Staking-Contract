// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

contract StakingContractImplementation {
    address tokenAddress;
    uint totalStake;
    uint constant COCO_PER_SECOND = 1 ;
    mapping(address => uint) balances;
    mapping(address => uint) unclaimedRewards;
    mapping(address => uint) lastUpdated ;

    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
    }
    function stake() public payable {
        require(msg.value > 0, "stake cannot be ZERO");
        balances[msg.sender] += msg.value;
        totalStake += msg.value;
    }
    function unstake(uint _amount) public {
        require(_amount <= balances[msg.sender], "not enough Stake");
        payable(msg.sender).transfer(_amount);
        balances[msg.sender] += _amount;
        totalStake += _amount;
    }

    function getRewards(address _address) view public returns(uint) {
        uint currentReward = unclaimedRewards[_address] ;
        uint updateTime = lastUpdated[_address] ;
        uint newRewards = (block.timestamp - updateTime) * balances[_address] ;
        return currentReward + newRewards ;
    }
    function claimRewards() public {
        
    }
    function balancesOf (address _address) public view returns(uint) {
        return balances[_address] ;
    }
}
