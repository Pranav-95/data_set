// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Charity {
    address public owner;
    uint public totalDonations;

    // Struct to store donor information
    struct Donation {
        address donor;
        string name;
        uint amount;
    }

    // Array to hold all donations
    Donation[] public donations;

    event DonationReceived(address indexed donor, string name, uint amount);

    constructor() {
        owner = msg.sender;
    }

    function donate(string memory name) external payable {
        require(msg.value > 0, "Donation must be greater than zero");
        totalDonations += msg.value;

        // Store the donation details
        donations.push(
            Donation({donor: msg.sender, name: name, amount: msg.value})
        );

        emit DonationReceived(msg.sender, name, msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "Only the owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }

    function getContractBalance() external view returns (uint) {
        return address(this).balance;
    }

    function getAllDonations() external view returns (Donation[] memory) {
        return donations;
    }
}
