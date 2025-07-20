// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

interface ICOCOcoin {
     function mint(address _to , uint _amount) external ;
}


contract StakingContractImplementation {
    uint totalStake;
    uint constant REWARD_PER_SEC_PER_ETH = 1 ;
    ICOCOcoin public COCOcoinAddress ;

    struct UserInfo {
        uint stakedBalance ;
        uint lastUpdated ;
        uint unclaimedRewards ;
    }
    mapping (address => UserInfo) userInfo ;

    constructor(ICOCOcoin _tokenAddress) {
        COCOcoinAddress = _tokenAddress;
    }

    function _updateRewards(address _address) internal{
        UserInfo storage user = userInfo[_address] ;

        if( user.lastUpdated == 0 ) {
            user.lastUpdated = block.timestamp ;
            return ;
        }

        uint timeDifference = block.timestamp - user.lastUpdated ;

        if(timeDifference == 0) {
            return ; 
        }

        uint newRewards = (user.stakedBalance * timeDifference) * REWARD_PER_SEC_PER_ETH ;

        user.unclaimedRewards += newRewards ;
        user.lastUpdated = block.timestamp ;
    }


    function stake(uint _amount) public payable {
       require(_amount == msg.value , "amount mismatch");
       require(_amount > 0 , "stake cannot be Zero");

       _updateRewards(msg.sender);

       userInfo[msg.sender].stakedBalance += _amount ;
       totalStake += _amount ;
    }
    function unstake(uint _amount) public {
        require(_amount > 0 , "amount cannot be zero");
        require(_amount <= userInfo[msg.sender].stakedBalance, "not enough stake");

        _updateRewards(msg.sender);
        userInfo[msg.sender].stakedBalance -= _amount ;
        totalStake -= _amount ;

        payable(msg.sender).transfer(_amount) ;
    }

    function getRewards(address _address) view public returns(uint) {
       UserInfo memory user = userInfo[_address] ;

        uint timeDifference = block.timestamp - user.lastUpdated ;
        if(timeDifference == 0) {
            return user.unclaimedRewards ;
        }

        uint newRewards = (user.stakedBalance * timeDifference) * REWARD_PER_SEC_PER_ETH ;
        return user.unclaimedRewards + newRewards ;

    }
    function claimRewards() public {
        _updateRewards(msg.sender);
        ICOCOcoin(COCOcoinAddress).mint(msg.sender,userInfo[msg.sender].unclaimedRewards);
        userInfo[msg.sender].unclaimedRewards = 0;
    }
    
}
