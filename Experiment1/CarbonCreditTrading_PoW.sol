// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

// Define the smart contract
contract CarbonCreditTrading {
    address public owner;
    uint public carbonCreditsAvailable;
    uint public pricePerCredit;
    //Define variables for balances and puzzle
    mapping (address => uint) public balances;
    mapping (bytes32 => bool) public puzzle;

    event Buy(address indexed buyer, uint amount, uint price);
    event Sell(address indexed seller, uint amount, uint price);
     
    // Initialize contract 
    constructor(uint initialCarbonCredits, uint rate) {
        owner = msg.sender;
        carbonCreditsAvailable = initialCarbonCredits;
        pricePerCredit = rate;
    }
    // function to buy the carbon credits  on sale
    function buyCarbonCredits(uint amount) public payable {
        require(msg.value >= amount * pricePerCredit, "Incorrect funds available");
        require(carbonCreditsAvailable >= amount, "Not enough carbon credits available");
        // update balance of owner who buys the credit
        balances[msg.sender] += amount;
        // update balance of organization who sells
        carbonCreditsAvailable -= amount;

        emit Buy(msg.sender, amount, msg.value);
    }
 
   // function to sell the carbon credits 
    function sellCarbonCredits(uint amount) public {
        require(balances[msg.sender] >= amount, "Not sufficient balance");

        // update balance of owner who sells
        balances[msg.sender] -= amount;

        // update balance of organization who buys  
        carbonCreditsAvailable += amount;

        payable(msg.sender).transfer(amount * pricePerCredit);

        emit Sell(msg.sender, amount, pricePerCredit);
    }

    // function to execute validation using PoW
    function submitProofOfWork(bytes32 hash, uint difficulty) public {
        require(difficulty >= 1 && difficulty <= 256, "Invalid difficulty");

        bytes32 solution = sha256(abi.encodePacked(hash, msg.sender, difficulty));
        require(!puzzle[solution], "Solution already submitted");
        bytes32 target = bytes32(2 ** (256 - difficulty));
       
        require(hash <= target, "Solution does not meet difficulty requirement");

        puzzle[solution] = true;
        balances[msg.sender] += 1;

        emit Buy(msg.sender, 1, pricePerCredit);
    }
}
