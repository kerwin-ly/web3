// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DataType {
    bool boolVal = true;
    uint256 unitNum = 300; // can be 0 ~ 2^256 - 1
    int256 intNum = -300; // can be -2^256 to 2^256 -1
    bytes8 byteVal = "testtest"; // largest bytes32
    string stringVal = "test hello"; // space is dynamic depends on values size
    address addr = 0x592F227c3A2cf39689F5106685f4Efbdc3fCD537;

    struct Info {
        string message;
        uint256 id;
        string name;
    }
    Info[] infos;
    mapping (uint256 => Info) public infoMap;
}