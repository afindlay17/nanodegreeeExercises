pragma solidity ^0.4.25;

// It's important to avoid vulnerabilities due to numeric overflow bugs
// OpenZeppelin's SafeMath library, when used correctly, protects agains such bugs
// More info: https://www.nccgroup.trust/us/about-us/newsroom-and-events/blog/2018/november/smart-contract-insecurity-bad-arithmetic/

import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract ExerciseC6B {
  using SafeMath for uint256; // Allow SafeMath functions to be called for all uint256 types (similar to "prototype" in Javascript)
  mapping(address => uint256) private sales; // Exercise 1 - Checks, Effects, Interation
  uint256 private enabled = block.timestamp; // Exercise 2 - Rate Limiting
  uint256 private counter = 1; //Exercise 3 - Re-Entrancy Guard

  constructor() public { }

  modifier rateLimit(uint time) {
    require (block.timestamp >= enabled, "Please wait sufficient time until this function can be called");
    enabled = enabled.add(time);
    _;
  }

  modifier entrancyGuard() {
    counter = counter.add(1);
    uint guard = counter;
    _;
    require (guard == counter, "That is not allowed");
  }
 
  // Using any text editor, write a function safeWithdraw(uint256) that protects against re-entrancy attacks 
  // using the Checks-Effects-Interaction pattern based on these requirements.
  function safeWithDraw(uint256 amount) rateLimit(30) {
    // 1. Checks
    // Verify caller is an EOA
    require (msg.sender == tx.origin, "Contracts not allowed");
    // Verify caller has adequate funds to withdraw
    require (sales[msg.sender] >= amount, "Insufficient funds");

    // 2. Effects
    // Reset sales for caller address to zero 
    uint senderAmount = sales[msg.sender];
    sales[msg.sender] = sales[msg.sender].sub(senderAmount);

    // 3. Interaction
    // Transfer value of sales for caller to caller address
    msg.sender.transfer(senderAmount);
  }
 
}
