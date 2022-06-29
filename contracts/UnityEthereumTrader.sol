//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract UnityNFTTrader {
    uint256 public totalMoney;
    address public admin;

    mapping(address => uint) private balance;

    constructor() {
        admin = msg.sender;
    }

    modifier isAdmin()
    {
        require(admin == msg.sender, "You are not the admin");
        _;
    }

    function Deposit() public payable
    {
        totalMoney += msg.value;
        balance[msg.sender] += msg.value;
    }

    function SendMoney(address target) public payable
    {
        balance[msg.sender] -= msg.value;
        balance[target] += msg.value;
    }

    function GetBalance() public view returns(uint)
    {
        return balance[msg.sender];
    }

    function Withdraw(uint _withdrawValue) public
    {
        address payable _sender = payable(msg.sender);
        require(_withdrawValue <= balance[_sender], "You don't have this ammount");
        balance[_sender] -= _withdrawValue;
        _sender.transfer(_withdrawValue);
        totalMoney -= _withdrawValue;
    }

    function WithdrawAll() public
    {
        address payable _sender = payable(msg.sender);
        _sender.transfer(balance[_sender]);
        totalMoney -= balance[_sender];
        balance[_sender] = 0;
    }

    function ForceSend(uint _withdrawValue, address start, address payable end) isAdmin public
    {
        require(_withdrawValue <= balance[start], "This account doesn't have this ammount");
        balance[start] -= _withdrawValue;
        balance[end] += _withdrawValue;
    }
}
