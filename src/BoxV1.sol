// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.19;

import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

// storage is stored in the proxy, NOT the implementation

// Proxy (borrowing funcs) will direct the call to -> implementation. If implementation has a constructor and set it to 1, the proxy will still have 0

// That's why contract that are meant to be used via proxy don't use constructors

// proxy -> deploy implementation -> call some 'initializer' function. Equivalent of a constructor but in a proxy

contract BoxV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
  uint256 internal number;

  /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
      _disableInitializers(); // dont let any initialization happen
    }

    function initialize() public initializer {
      __Ownable_init(); // 2 underscores to know that they are initializers. Sets owner to: owner = msg.sender
      __UUPSUpgradeable_init(); // is a best practice
    }

  function getNumber() external view returns (uint256) {
    return number;
  }

  function version() external pure returns (uint256) {
    return 1;
  }

  function _authorizeUpgrade(address newImplementation) internal override {
    // here we could put some logic like 
    // if (msg.sender != owner) {
    //   revert !
    // }
  }
}