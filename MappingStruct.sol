pragma solidity ^0.6.0;

contract MappingStruct {
    
    struct Payment {
        uint amount;
        uint timestamp;
    }
    
    struct Balance{
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }
    
    mapping (address => Balance) public balanceRecived;
   
    function sendMoney() public payable {
        balanceRecived[msg.sender].totalBalance += msg.value;
        Payment memory payment = Payment(msg.value, now);
        balanceRecived[msg.sender].payments[balanceRecived[msg.sender].numPayments] = payment;
        balanceRecived[msg.sender].numPayments++;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceRecived[msg.sender].totalBalance, "not enough funds");
        balanceRecived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
}
