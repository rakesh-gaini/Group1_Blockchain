// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./CarbonCreditTrading.sol";

contract MainChain {
    
    address public owner;
    CarbonCreditTrading public carbonCreditTrading;
    
    constructor(address _carbonCreditTrading) {
        owner = msg.sender;
        carbonCreditTrading = CarbonCreditTrading(_carbonCreditTrading);
    }
    
    function mintCCredits() public {
        require(msg.sender == owner, "Only owner can mint carbon credits");
        carbonCreditTrading.mintCarbonCredits();
    }

    function stakeCredits(address from, uint stake) public {
        carbonCreditTrading.stakeCryptocurrency(from, stake);
    }

    function balanceUpdates(address _to) public {
        carbonCreditTrading.updateBalance(_to);
    }

    function transferCarbonCredits(address _from, address _to, uint _amount) public {
        //require(msg.sender == address(carbonCreditTrading), "Only the sidechain contract can transfer carbon credits");
        carbonCreditTrading.sellCarbonCredits(_from, _to, _amount);
    }
    
    function buyCarbonCredits(address payable to, uint amount) public payable {
        //require(msg.sender == address(carbonCreditTrading), "Only the sidechain contract can sell carbon credits");
        carbonCreditTrading.buyCarbonCredits(to, amount);
    }
    
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw ether");
        uint amount = address(this).balance;
        payable(msg.sender).transfer(amount);
    }
}
