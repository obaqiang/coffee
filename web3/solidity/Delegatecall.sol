// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// NOTE: Deploy this contract first
contract B {
    // NOTE: storage layout must be the same as contract A
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _contract, uint _num) public payable {
        // A's storage is set, B is not modified.
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
    }
}


// delegatecall is a low level function similar to call.

// When contract A executes delegatecall to contract B, B's code is excuted

// with contract A's storage, msg.sender and msg.value.


// 在 Solidity 中，delegatecall 是一种特殊的调用方式，在这种调用中，被调用合约的代码会被加载到当前合约的上下文中执行。
// 简单来说，delegatecall 允许一个合约将它的执行环境委托给另一个合约，使得另一个合约可以访问当前合约的存储和状态变量。

// delegatecall 的作用是允许一个合约调用另一个合约中的函数，并且在调用过程中保持当前合约的上下文不变。这样做的好处是可以实现更加灵活的代码复用和模块化设计。
// 例如，我们可以将一些常用的功能封装成一个单独的合约，然后在其他合约中通过 delegatecall 调用该合约中的函数来使用这些功能，而不需要重复编写代码。

// 需要注意的是，delegatecall 可以很方便地实现代码复用，但也存在潜在的风险。
// 由于被调用合约的代码会被加载到当前合约的上下文中执行，因此如果被调用合约中的代码有恶意操作，可能会导致当前合约的存储和状态变量被篡改。因此，在使用 delegatecall 时需要格外谨慎，确保被调用合约的安全性。