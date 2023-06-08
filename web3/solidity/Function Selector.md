When a function is called, the first 4 bytes of calldata specifies which function to call.

This 4 bytes is called a function selector.

Take for example, this code below. It uses call to execute transfer on a contract at the address addr.

``` solidity
addr.call(abi.encodeWithSignature("transfer(address,uint256)", 0xSomeAddress, 123))
```

The first 4 bytes returned from abi.encodeWithSignature(....) is the function selector.

Perhaps you can save a tiny amount of gas if you precompute and inline the function selector in your code?

Here is how the function selector is computed.

``` solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract FunctionSelector {
    /*
    "transfer(address,uint256)"
    0xa9059cbb
    "transferFrom(address,address,uint256)"
    0x23b872dd
    */
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
}

```

这段 Solidity 代码实现了一个名为FunctionSelector的智能合约，其中包含了一个名为getSelector的函数。这个函数接受一个字符串类型的参数 _func，返回该函数的四字节函数选择器。

所谓函数选择器是对Solidity中的函数进行编码的一种方式，它在调用时可以帮助区分不同的函数。在这个合约中，getSelector函数使用keccak256哈希函数将传入的函数名称 _func 计算出其对应的函数选择器，并以4字节的形式返回。

在这个示例合约中，函数名称 "transfer(address,uint256)" 对应的函数选择器是0xa9059cbb，而函数名称 "transferFrom(address,address,uint256)" 对应的函数选择器是0x23b872dd。