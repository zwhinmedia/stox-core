pragma solidity ^0.4.23;


/*
    @title Provides support and utilities for contract ownership
*/
contract Ownable {
    address public owner;
    address public newOwner;

    event OwnerUpdate(address _prevOwner, address _newOwner);

    /*
        @dev constructor
    */
    constructor(address _owner) public {
        owner = _owner;
    }

    /*
        @dev allows execution by the owner only
    */
    modifier ownerOnly {
        require(msg.sender == owner);
        _;
    }

    /*
        @dev allows transferring the contract ownership
        the new owner still needs to accept the transfer
        can only be called by the contract owner

        @param _newOwner    new contract owner
    */
    function transferOwnership(address _newOwner) public ownerOnly {
        require(_newOwner != owner);
        newOwner = _newOwner;
    }

    /*
        @dev used by a new owner to accept an ownership transfer
    */
    function acceptOwnership() public {
        require(msg.sender == newOwner);
        emit OwnerUpdate(owner, newOwner);
        owner = newOwner;
        newOwner = address(0);
    }
}
