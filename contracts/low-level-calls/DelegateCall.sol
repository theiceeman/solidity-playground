// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// NOTE: Deploy this contract first
contract B {
    // NOTE: storage layout must be the same as contract A
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) public payable {
        num = _num;     // num = 2 * _num;
        sender = msg.sender;
        value = msg.value;
    }
}



contract A {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(address _contract, uint256 _num) public payable {
        // A's storage is set, B is not modified.

        // (bool success, bytes memory data) = _contract.delegatecall(
        //     abi.encodeWithSelector(B.setVars.selector, _num)
        // );

        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );

        require(success, "delegatecall failed!");
    }
}
