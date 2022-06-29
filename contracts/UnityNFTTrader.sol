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

    function Withdraw(uint _withdrawValue, address payable _sender) public
    {
        require(_sender == msg.sender, "You are not the owner of this account");
        require(_withdrawValue <= balance[_sender], "You don't have this ammount");
        balance[_sender] -= _withdrawValue;
        _sender.transfer(_withdrawValue);
        totalMoney -= _withdrawValue;
    }

    function WithdrawAll(address payable _sender) public
    {
        require(_sender == msg.sender, "You are not the owner of this account");
        _sender.transfer(balance[_sender]);
        totalMoney -= balance[_sender];
        balance[_sender] = 0;
    }
}