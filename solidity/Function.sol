// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Func {
    string str = "test";
    int256 num = 0;
    struct Info {
        string message;
        uint256 id;
        address addr;
    }
    Info[] items;
    mapping (uint256 => Info) public infoMap;

    // view: any states in this contract cannot be modified
    function getValue() external view returns (string memory) {
        return str;
    }

    function setValue(string memory _s) public {
        str = _s;
    }

    // pure: don't read or modify states in contract
    function getSum(int256 value) external pure returns (int256) {
        return value + 10;
    }

    /*
    storage: accessible permanently
    memory: accessible temporarily, can be modified when executing
    calldata: accessible temporarily, cannot be modified when executing
    stack
    codes
    logs
    */
    function addInfo(string memory _s, uint256 _id) public {
        Info memory _info = Info(_s, _id, msg.sender);
        items.push(_info);
        infoMap[_id] = _info;
    }

    function getAllInfo() external view returns (Info[] memory) {
        return items;
    }

    function getInfo(uint256 _id) external view returns (Info memory) {
        for (uint256 i = 0; i < items.length; i++) {
            if (items[i].id == _id) {
                return items[i];
            }
        }
    } 
}