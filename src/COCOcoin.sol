// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol" ;
import "node_modules/@openzeppelin/contracts/access/Ownable.sol" ;

contract COCOcoin is ERC20, Ownable  {
    address stakingContract ;
    
    constructor(address _stakingContract) ERC20("COCO", "COCO") Ownable(msg.sender) {
        stakingContract = _stakingContract ;
    }

    function updateStakingContractAddress (address _stakingContract) onlyOwner {
        stakingContract = _stakingContract ;
    }

    function mint(address _to , uint _amount) public  {
        require(msg.sender == stakingContract , "forbidden !");
        _mint(_to , _amount) ;
    }
}