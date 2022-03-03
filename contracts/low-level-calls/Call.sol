//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Caller {
    event Response(bool success, bytes data);

    function testCallFoo(address payable _addr) public payable {
        (bool success, bytes memory data) = _addr.call{
            value: msg.value,
            gas: 5000
        }(
            abi.encodeWithSignature(
                "foo(string,uint256)",
                "calling the foo",
                123
            )
        );
        emit Response(success, data);
    }

    // Calling a function that does not exist triggers the fallback function.
    function testCallDoesNotExist(address _addr) public payable {
        (bool success, bytes memory data) = _addr.call{
            value: msg.value,
            gas: 5000
        }(abi.encodeWithSignature("doesNotExist()"));

        emit Response(success, data);
    }
    
    function justSendEther(address payable _addr) public payable {
        (bool success, bytes memory data) = _addr.call{
            value: msg.value,
            gas: 5000
        }("");
        emit Response(success, data);
    }
}

contract Reciever {
    event Recieved(address caller, uint256 amount, string message);

    fallback() external payable {
        emit Recieved(msg.sender, msg.value, "Fallback was called");
    }

    receive() external payable {
        emit Recieved(msg.sender, msg.value, "Receive was called");
    }

    function foo(string memory _message, uint256 _x)
        public
        payable
        returns (uint256)
    {
        emit Recieved(msg.sender, msg.value, _message);
        return _x + 1;
    }
}
